---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_default.lua
--      Miscellaneous functions inherited from minetest_game/default
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Flag set to true temporarily during calls to unilib.dig_up() and unilib.dig_up_multiple()
local in_dig_up_flag = false

---------------------------------------------------------------------------------------------------
-- Check user is allowed to interact with a node
---------------------------------------------------------------------------------------------------

function unilib.misc._can_interact_with_node(player, pos)

    -- Adapted from default/functions.lua, and called by the "container_chest_ordinary" package
    -- Notes from default:
    -- This method is not an official part of the API yet. This method may change in the future

    if player and player:is_player() then

        if core.check_player_privs(player, "protection_bypass") then
            return true
        end

    else

        return false

    end

    local meta = core.get_meta(pos)
    local owner = meta:get_string("owner")

    if not owner or owner == "" or owner == player:get_player_name() then
        return true
    end

    -- Is player wielding the right key?
    local item = player:get_wielded_item()
    if core.get_item_group(item:get_name(), "key") == 1 then

        local key_meta = item:get_meta()

        if key_meta:get_string("secret") == "" then

            local key_oldmeta = item:get_meta():get_string("")
            if key_oldmeta == "" or not core.parse_json(key_oldmeta) then
                return false
            end

            key_meta:set_string("secret", core.parse_json(key_oldmeta).secret)
            item:set_metadata("")

        end

        return meta:get_string("key_lock_secret") == key_meta:get_string("secret")

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Dig upwards (mostly used by plants, but also used by scaffolding)
---------------------------------------------------------------------------------------------------

--[[
function unilib.misc._dig_up(pos, node, digger)

    -- Adapted from default/functions.lua
    -- e.g. for papyrus, digging the base node auto-digs papyrus nodes above it

    if digger == nil then
        return
    end

    local np = {x = pos.x, y = pos.y + 1, z = pos.z}
    local nn = core.get_node(np)
    if nn.name == node.name then
        core.node_dig(np, nn, digger)
    end

end
]]--
function unilib.misc._dig_up(pos, node, digger, max_height)

    -- Adapted from default/functions.lua
    -- e.g. for papyrus, digging the base node auto-digs papyrus nodes above it
    -- This version replaces the original, in order to avoid recursion

    if in_dig_up_flag then

        -- Prevent recursion
        return

    end

    if digger == nil then
        return
    end

    max_height = max_height or 100
    in_dig_up_flag = true

    for y = 1, max_height do

        local up_pos = vector.offset(pos, 0, y, 0)
        local up_node = core.get_node(up_pos)
        if up_node.name ~= node.name then
            break
        end

        if not core.node_dig(up_pos, up_node, digger) then
            break
        end

    end

    in_dig_up_flag = false

end

--[[
function unilib.misc._dig_up_multiple(pos, full_name_list, digger)

    -- Adapted from aotearoa/functions.lua
    -- Unlike the function above, "node_list" is a list of full node names, e.g.
    --      {"unilib:plant_raupo", "unilib:plant_raupo_with_flowers"}

    if digger == nil then
        return
    end

    local np = {x = pos.x, y = pos.y + 1, z = pos.z}

    for _, full_name in ipairs(full_name_list) do

        local nn = core.get_node(np)
        if nn.name == full_name then
            core.node_dig(np, nn, digger)
        end

    end

end
]]--
function unilib.misc._dig_up_multiple(pos, full_name_list, digger, max_height)

    -- Adapted from aotearoa/functions.lua and minetest_game/default/functions.lua
    -- Unlike the function above, "node_list" is a list of full node names, e.g.
    --      {"unilib:plant_raupo", "unilib:plant_raupo_with_flowers"}
    -- This version replaces the original, in order to avoid recursion

    if in_dig_up_flag then

        -- Prevent recursion
        return

    end

    if digger == nil then
        return
    end

    max_height = max_height or 100
    in_dig_up_flag = true

    for y = 1, max_height do

        local up_pos = vector.offset(pos, 0, y, 0)
        local up_node = core.get_node(up_pos)
        if not unilib.utils.is_value_in_list(up_node.name, full_name_list) then
            break
        end

        if not core.node_dig(up_pos, up_node, digger) then
            break
        end

    end

    in_dig_up_flag = false

end

-- Errors are hard to handle, instead we rely on resetting this value the next step
core.register_globalstep(function()
    in_dig_up_flag = false
end)

---------------------------------------------------------------------------------------------------
-- Get the hotbar background
---------------------------------------------------------------------------------------------------

function unilib.misc._get_hotbar_bg(x, y)

    -- Adapted from default/init.lua
    -- Make sure that the hotbar background is available for code that needs it (e.g. the
    --      ordinary furnace), in case default isn't available
    --
    -- N.B. All six GUI textures from default have been imported into unilib's textures folder,
    --      though some of them aren't actually used

    local out = ""

    for i = 0, 7 do
        out = out .. "image[" .. x + i .. "," .. y .. ";1,1;unilib_gui_hb_bg.png]"
    end

    return out

end

---------------------------------------------------------------------------------------------------
-- Optimised function to put all items from an inventory into a drops list
---------------------------------------------------------------------------------------------------

function unilib.misc._get_inventory_drops(pos, inventory, drops)

    -- Adapted from default/functions.lua, and called by various minetest_game mods
    -- In unilib, called by unilib.register_bookshelf()

    local inv = core.get_meta(pos):get_inventory()
    local n = #drops

    for i = 1, inv:get_size(inventory) do

        local stack = inv:get_stack(inventory, i)
        if stack:get_count() > 0 then

            drops[n+1] = stack:to_table()
            n = n + 1

        end

    end

end
