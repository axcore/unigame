---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- magnet_drop_base.lua
--      Set up Minecraft-style item drop. Code adapted from the "item_drop" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of connected players and their current auto-drop status. This table (and the associated
--      player attribute) can be updated by a call to unilib.magnet.toggle_player_auto_drop()
-- Keys are player names; the corresponding value is true if auto-drop is enabled, false otherwise
local player_auto_drop_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_auto_drop()

    -- Workaround to test if an item metadata (ItemStackMetaRef) is empty
    local function itemmeta_is_empty(meta)

        local t = meta:to_table()
        for k, v in pairs(t) do

            if k ~= "fields" then
                return false
            end

            if type(v) ~= "table" then
                return nil
            end

            if next(v) ~= nil then
                return false
            end

        end

        return true

    end

    -- Test if the item has special information such as metadata
    local function can_split_item(item)
        return item:get_wear() == 0 and itemmeta_is_empty(item:get_meta())
    end

    local function spawn_items(pos, items_to_spawn)

        for i = 1,#items_to_spawn do

            local obj = core.add_item(pos, items_to_spawn[i])
            if not obj then

                unilib.utils.show_error(
                    "../lib/effects/magnet/magnet_drop_base.lua: couldn't spawn item", name
                )

                return

            end

            local vel = obj:get_velocity()
            local x = math.random(-5, 4)
            if x >= 0 then
                x = x + 1
            end

            vel.x = 1 / x
            local z = math.random(-5, 4)
            if z >= 0 then
                z = z + 1
            end

            vel.z = 1 / z
            obj:set_velocity(vel)

        end

    end

    local old_handle_node_drops = core.handle_node_drops
    function core.handle_node_drops(pos, drops, player)

        -- (Original code)
        --[[
        if not player or player.is_fake_player then

            -- Node Breaker and similar machines should receive items in the inventory
            return old_handle_node_drops(pos, drops, player)

        end
        ]]--

        -- (Modified unilib code, to enable toggling auto-get on a per-player basis)
        if not player or
                player.is_fake_player or
                not player_auto_drop_table[player:get_player_name()] then

            -- Node Breaker and similar machines should receive items in the inventory
            return old_handle_node_drops(pos, drops, player)

        end

        for i = 1, #drops do

            local item = drops[i]
            if type(item) == "string" then

                -- The string is not necessarily only the item name, so always convert it to
                --      ItemStack
                item = ItemStack(item)
            end

            local count = item:get_count()
            local name = item:get_name()

            -- Sometimes nothing should be dropped
            if name == "" or not core.registered_items[name] then
                count = 0
            end


            if count > 0 then

                -- Split items if possible
                local items_to_spawn = {item}
                if can_split_item(item) then

                    for i = 1,count do
                        items_to_spawn[i] = name
                    end

                end

                spawn_items(pos, items_to_spawn)

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (toggle magnet effects on a per-player basis)
---------------------------------------------------------------------------------------------------

function unilib.magnet.toggle_player_auto_drop(pname)

    if player_auto_drop_table[pname] == nil then

        return false

    elseif player_auto_drop_table[pname] == false then

        player_auto_drop_table[pname] = true
        unilib.utils.set_player_attribute(core.get_player_by_name(pname), "auto_drop_flag", "true")

    else

        player_auto_drop_table[pname] = false
        unilib.utils.set_player_attribute(core.get_player_by_name(pname), "auto_drop_flag", "false")

    end

    return player_auto_drop_table[pname]

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Set up Minecraft-style item drop
core.register_on_joinplayer(function(player)

    local pname = player:get_player_name()
    local pattrib = unilib.utils.get_player_attribute(player, "auto_drop_flag")
    if pattrib == "" or pattrib == "true" then
        player_auto_drop_table[pname] = true
    else
        player_auto_drop_table[pname] = false
    end

end)

core.register_on_leaveplayer(function(player)

    local pname = player:get_player_name()
    player_auto_drop_table[pname] = nil

end)

do_auto_drop()
