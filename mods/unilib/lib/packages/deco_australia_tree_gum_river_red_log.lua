---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_gum_river_red_log = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_gum_river_red_log.init()

    return {
        description = "River red gum tree log as decoration",
        depends = {
            "dirt_ordinary",
            "mushroom_brown",
            "tree_gum_river_red",
        },
        at_least_one = {
            "biome_australia_flinders_lofty",
            "biome_australia_flinders_lofty",
            "biome_australia_murray_darling_basin",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.deco_australia_tree_gum_river_red_log.exec()

    if unilib.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil then

        unilib.register_decoration_now(
            -- From australia/biome_flinders_lofty.lua
            "australia_tree_gum_river_red_log",
            "australia_tree_gum_river_red_log_1",
            {
                biomes = "australia_flinders_lofty",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 170,
                y_min = 36,
            }
        )

    end
    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_decoration_now(
            -- From australia/biome_great_dividing_range.lua
            "australia_tree_gum_river_red_log",
            "australia_tree_gum_river_red_log_2",
            {
                biomes = "australia_great_dividing_range",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 170,
                y_min = 36,
            }
        )

    end
    if unilib.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil then

        unilib.register_decoration_now(
            -- From australia/biome_murray_darling_basin.lua
            "australia_tree_gum_river_red_log",
            "australia_tree_gum_river_red_log_3",
            {
                biomes = "australia_murray_darling_basin",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 170,
                y_min = 36,
            }
        )

    end
    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_decoration_now(
            -- From australia/biome_victorian_forests.lua
            "australia_tree_gum_river_red_log",
            "australia_tree_gum_river_red_log_4",
            {
                biomes = "australia_victorian_forests",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 175,
                y_min = 36,
            }
        )

    end

end
