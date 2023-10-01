---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_wattle_golden = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_wattle_golden.init()

    return {
        description = "Golden wattle tree as decoration",
        depends = {"dirt_ordinary", "tree_wattle_golden"},
        at_least_one = {
            "biome_australia_flinders_lofty",
            "biome_australia_great_dividing_range",
            "biome_australia_murray_darling_basin",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.deco_australia_tree_wattle_golden.post()

    if unilib.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_wattle_golden_in_flinders_" .. i, nil, {
                -- From australia/biome_flinders_lofty.lua
                biomes = "australia_flinders_lofty",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 170,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_wattle_golden_in_murray_" .. i, nil, {
                -- From australia/biome_murray_darling_basin.lua
                biomes = "australia_murray_darling_basin",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 150,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_wattle_golden_in_range_" .. i, nil, {
                -- From australia/biome_great_dividing_range.lua
                biomes = "australia_great_dividing_range",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 150,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_wattle_golden_in_victoria_" .. i, nil, {
                -- From australia/biome_victorian_forests.lua
                biomes = "australia_victorian_forests",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 150,
                y_min = 36,
            })

        end

    end

end
