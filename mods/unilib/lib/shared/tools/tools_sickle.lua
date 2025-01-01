---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_sickle.lua
--      Sickle support functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From sickles/api.lua)
local default_sickle_uses = 120

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_wielded_item(player)

    -- Adapted from sickles/api.lua, get_wielded_item()

    if not core.is_player(player) then
        return
    end

    local itemstack = player:get_wielded_item()
    if itemstack == nil then
        return
    else
        return itemstack
    end

end

---------------------------------------------------------------------------------------------------
-- Sickle support functions
---------------------------------------------------------------------------------------------------

function unilib.tools._make_cuttable(full_name, cut_name, drop_name)

    -- Adapted from sickles/api.lua, sickles.register_cuttable()
    -- Modifies the definition of the "full_name" node, so it can be cut with a sickle
    --      (replacing the original node with "cut_name"), and dropping the node "drop_name"
    -- In the original mod, this was used with a range of items from different mods, such as
    --      dirts with turf, mossy cobbles, etc

    local def = core.registered_nodes[full_name]
    if def == nil then
        return
    end

    local default_handler = def.on_punch or core.node_punch
    unilib.override_item(full_name, {

        on_punch = function(pos, node, puncher, pointed_thing)

            local itemstack = get_wielded_item(puncher)
            local itemdef = itemstack:get_definition()
            local level = unilib.utils.get_group(itemdef, "sickle")
            if level == 0 then
                return default_handler(pos, node, puncher, pointed_thing)
            end

            local pname = puncher:get_player_name()
            if core.is_protected(pos, pname) then

                core.record_protection_violation(pos, pname)
                return

            end

            core.handle_node_drops(pos, {drop_name}, puncher)
            core.after(0, function()
                core.swap_node(pos, {name = cut_name, param2 = node.param2})
            end)

            if not unilib.utils.is_creative(pname) then

                local max_uses =
                        unilib.utils.get_group(itemdef, "sickle_uses") or default_sickle_uses
                itemstack:add_wear(math.ceil(unilib.constant.max_tool_wear / (max_uses - 1)))
                if itemstack:get_count() == 0 and itemdef.sound and itemdef.sound.breaks then
                    core.sound_play(itemdef.sound.breaks, {pos = pos, gain = 0.5})
                end

                puncher:set_wielded_item(itemstack)

            end

        end

    })

end

function unilib.tools._make_trimmable(full_name, trim_name)

    -- Adapted from sickles/api.lua, sickles.register_trimmable()
    -- Modifies the definition of the "full_name" node, so it can be trimmed with a sickle
    --      (replacing the original node with "trim_name")
    -- In the original mod, this was only used with crops (and not with produce)

    local def = core.registered_nodes[full_name]
    if def == nil then
        return
    end

    local handler = def.after_dig_node
    unilib.override_item(full_name, {

        after_dig_node = function(pos, old_node, old_metadata, digger)

            local itemstack = get_wielded_item(digger)
            local itemdef = itemstack:get_definition()
            local level = unilib.utils.get_group(itemdef, "sickle")
            if level == 0 then

                if handler ~= nil then
                    return handler(pos, old_node, old_metadata, digger)
                else
                    return
                end

            end

            local param2 = core.registered_nodes[trim_name].place_param2
            core.set_node(pos, { name = trim_name, param2 = param2 })

        end

    })

end
