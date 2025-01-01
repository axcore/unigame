---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_soil_convert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_soil_convert.init()

    return {
        description = "ABM to convert dry soil when near water (from minetest_game/farming and" ..
                " farming_redo)",
    }

end

function unilib.pkg.abm_standard_soil_convert.post()

    -- If water is near dry soil, then convert it to wet soil (and vice-versa)
    if not unilib.setting.mtgame_tweak_flag then

        -- Adapted from minetest_game/farming/nodes.lua
        unilib.register_abm({
            label = "Farming soil [abm_standard_soil_convert]",
            nodenames = {"group:field"},

            chance = 4,
            interval = 15,

            action = function(pos, node)

                local n_def = core.registered_nodes[node.name] or nil
                local wet = n_def.soil.wet or nil
                local base = n_def.soil.base or nil
                local dry = n_def.soil.dry or nil
                if not n_def or not n_def.soil or not wet or not base or not dry then
                    return
                end

                pos.y = pos.y + 1
                local nn = core.get_node_or_nil(pos)
                if not nn or not nn.name then
                    return
                end

                local nn_def = core.registered_nodes[nn.name] or nil
                pos.y = pos.y - 1

                if nn_def and nn_def.walkable and core.get_item_group(nn.name, "plant") == 0 then

                    core.set_node(pos, {name = base})
                    return

                end

                -- Check if there is water nearby
                local wet_lvl = core.get_item_group(node.name, "wet")
                if core.find_node_near(pos, 3, {"group:water"}) then

                    -- If it is dry soil and not base node, turn it into wet soil
                    if wet_lvl == 0 then
                        core.set_node(pos, {name = wet})
                    end

                else

                    -- Only turn back into dry soil if there are no unloaded blocks (and therefore
                    --      possible water sources) nearby
                    if not core.find_node_near(pos, 3, {"ignore"}) then

                        -- Turn it back into base if it is already dry
                        if wet_lvl == 0 then

                            -- Only turn it back if there is no plant/seed on top of it
                            if core.get_item_group(nn.name, "plant") == 0 and
                                    core.get_item_group(nn.name, "seed") == 0 then
                                core.set_node(pos, {name = base})
                            end

                        -- If it's wet, turn it back into dry soil
                        elseif wet_lvl == 1 then

                            core.set_node(pos, {name = dry})

                        end

                    end

                end

            end,
        })

    else

        -- Adapted from farming_redo/soil.lua
        unilib.register_abm({
            label = "Farming soil [abm_standard_soil_convert]",
            nodenames = {"group:field"},

            catch_up = false,
            chance = 4,
            interval = 15,

            action = function(pos, node)

                local ndef = core.registered_nodes[node.name]
                if not ndef or
                        not ndef.soil or
                        not ndef.soil.wet or
                        not ndef.soil.base or
                        not ndef.soil.dry then
                    return
                end

                pos.y = pos.y + 1
                local nn = core.get_node_or_nil(pos)
                pos.y = pos.y - 1

                if nn then
                    nn = nn.name
                else
                    return
                end

                -- Check what is on top of the soil. If solid/not plant, then change soil to dirt
                if core.registered_nodes[nn] and
                        core.registered_nodes[nn].walkable and
                        core.get_item_group(nn, "plant") == 0 then

                    core.set_node(pos, {name = ndef.soil.base})
                    return

                end

                -- If map around the soil is not loaded, then skip until loaded
                if core.find_node_near(pos, 3, {"ignore"}) then
                    return
                end

                -- Check if water is within 3 nodes horizontally and 1 below
                if #core.find_nodes_in_area(
                    {x = pos.x + 3, y = pos.y - 1, z = pos.z + 3},
                    {x = pos.x - 3, y = pos.y, z = pos.z - 3},
                    {"group:water"}
                ) > 0 then

                    core.set_node(pos, {name = ndef.soil.wet})

                elseif node.name == ndef.soil.wet then

                    core.set_node(pos, {name = ndef.soil.dry})

                elseif node.name == ndef.soil.dry and core.get_item_group(nn, "plant") == 0 then

                    core.set_node(pos, {name = ndef.soil.base})

                end

            end,
        })

    end

    unilib.register_obsolete_abm({
        mod_origin = "farming",
        label = "Farming soil",
    })

end
