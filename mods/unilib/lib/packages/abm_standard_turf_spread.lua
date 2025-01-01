---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_turf_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_turf_spread.init()

    return {
        description = "ABM to handle turf/grass spread (from minetest_game/default)",
    }

end

function unilib.pkg.abm_standard_turf_spread.post()

    -- Adapted from default/functions.lua
    -- Converts dirt nodes into dirt-with-turf nodes, matching one of the surrounding nodes. Some
    --      grasses can also convert the dirt beneath them to a dirt-with-turf node

    local fertile_dirt_list = {}
    for k, v in pairs(unilib.global.fertile_dirt_table) do
        table.insert(fertile_dirt_list, v)
    end

    if #fertile_dirt_list > 0 then

        unilib.register_abm({
            label = "Grass/turf spread [abm_standard_turf_spread]",
            nodenames = fertile_dirt_list,
            neighbors = {
                "air",
                "group:grass",
                "group:dry_grass",
                "unilib:snow_ordinary",
            },

            catch_up = false,
            chance = 50,
            interval = 6 / unilib.setting.abm_spread_factor,

            action = function(pos, node)

                -- Check for darkness: night, shadow or under a light-blocking node
                local above = {x = pos.x, y = pos.y + 1, z = pos.z}
                if (core.get_node_light(above) or 0) <
                        unilib.constant.light_min_grow_sapling then
                    return
                end

                -- Look for spreading_dirt_type neighbours, which are typically dirt-with-turf nodes
                -- Ignore a dirt-with-turf node of a different dirt type
                local neighbour_pos = core.find_node_near(pos, 1, "group:spreading_dirt_type")
                if neighbour_pos then

                    local neighbour = core.get_node(neighbour_pos)
                    local neighbour_data_table = unilib.global.dirt_with_turf_table[neighbour.name]
                    if neighbour_data_table ~= nil then

                        if not unilib.setting.unfussy_turf_flag then

                            if "unilib:" .. neighbour_data_table.dirt_part_name == node.name then

                                -- (Original minetest_game behaviour, turf only spreads to
                                --      neighbouring dirt of the same type)
                                core.set_node(pos, {name = neighbour.name})
                                return

                            end

                        else

                            -- (New behaviour, turf can spread to any suitable neighbouring dirt)
                            local neighbour_dirt = "unilib:" .. neighbour_data_table.dirt_part_name
                            local this_turf = node.name .. "_with_" ..
                                    neighbour_data_table.turf_part_name

                            if core.registered_nodes[this_turf] ~= nil or
                                    neighbour_dirt == node.name then

                                core.set_node(pos, {name = this_turf})
                                return

                            end

                        end

                    end

                end

                -- Otherwise, is there a turf seeder (e.g. dry grass or ordinary snow) just above?
                --      If so, it seeds turf onto this dirt
                local seeder_name = core.get_node(above).name
                if unilib.global.turf_seeder_table[seeder_name] ~= nil and
                        unilib.global.turf_seeder_table[seeder_name][node.name] ~= nil then

                    core.set_node(
                        pos, {name = unilib.global.turf_seeder_table[seeder_name][node.name]}
                    )

                end

            end,
        })
        unilib.register_obsolete_abm({
            mod_origin = "default",
            label = "Grass spread",
        })

    end

end
