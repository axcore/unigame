---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_turf_kill = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_turf_kill.init()

    return {
        description = "ABM to handle removal of turf in darkness (from minetest_game/default)",
    }

end

function unilib.pkg.abm_standard_turf_kill.post()

    -- Adapted from default/functions.lua
    -- Handle removal of turf in darkness

    unilib.register_abm({
        label = "Remove turf in darkness [abm_standard_turf_kill]",
        nodenames = {"group:spreading_dirt_type", "unilib:dirt_dry_with_turf_dry"},

        catch_up = false,
        chance = 50,
        interval = 8,

        action = function(pos, node)

            local above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local above_name = core.get_node(above).name
            local def_table = core.registered_nodes[above_name]
            if above_name ~= "ignore" and
                    def_table and not (
                        (def_table.sunlight_propagates or def_table.paramtype == "light") and
                        def_table.liquidtype == "none"
                    ) and unilib.global.dirt_with_turf_table[node.name] ~= nil then

                core.set_node(
                    pos,
                    {
                        name = "unilib:" ..
                                unilib.global.dirt_with_turf_table[node.name]["dirt_part_name"]
                    }
                )

            end

        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "default",
        label = "Grass covered",
    })

end
