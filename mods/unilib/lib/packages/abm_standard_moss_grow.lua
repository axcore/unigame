---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_moss_grow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_moss_grow.init()

    return {
        description = "ABM to handle moss growth (from minetest_game/default and underch)",
        depends = "shared_standard",
    }

end

function unilib.pkg.abm_standard_moss_grow.post()

    -- Adapted from default/functions.lua and underch/init.lua
    -- Moss grows on cobble (and some of its stair variants) when they are near water

    if unilib.pkg.shared_standard.moss_flag then

        unilib.register_abm({
            label = "Moss growth on cobble [abm_standard_moss_grow]",
            nodenames = {"group:cobble", "group:wall"},
            neighbors = {"group:water"},

            catch_up = false,
            chance = 200,
            interval = 16,

            action = function(pos, node)

                node.name = unilib.pkg.shared_standard[node.name]
                if node.name then
                    core.set_node(pos, node)
                end

            end,
        })
        unilib.register_obsolete_abm({
            mod_origin = "default",
            label = "Moss growth",
        })

    end

end
