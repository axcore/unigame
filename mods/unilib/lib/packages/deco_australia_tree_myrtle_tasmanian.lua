---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_myrtle_tasmanian = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_myrtle_tasmanian.init()

    return {
        description = "Tasmanian myrtle tree as decoration",
        depends = {"dirt_ordinary", "tree_myrtle_tasmanian"},
        at_least_one = {"biome_australia_tasmania", "biome_australia_victorian_forests"},
    }

end

function unilib.pkg.deco_australia_tree_myrtle_tasmanian.post()

    if unilib.pkg_executed_table["biome_australia_tasmania"] ~= nil then

        for i = 1, 3 do

            unilib.register_decoration_now(
                -- From australia/biome_tasmania.lua
                "australia_tree_myrtle_tasmanian_in_tasmania_" .. i,
                nil,
                {
                    biomes = "australia_tasmania",
                    place_on = "unilib:dirt_ordinary_with_turf",
                    y_max = 150,
                    y_min = 36,
                }
            )

        end

    end
    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        for i = 1, 3 do

            unilib.register_decoration_now(
                -- From australia/biome_victorian_forests.lua
                "australia_tree_myrtle_tasmanian_in_victoria_" .. i,
                nil,
                {
                    biomes = "australia_victorian_forests",
                    place_on = "unilib:dirt_ordinary_with_turf",
                    y_max = 150,
                    y_min = 36,
                }
            )

        end

    end

end
