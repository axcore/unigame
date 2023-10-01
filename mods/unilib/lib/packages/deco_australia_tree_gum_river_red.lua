---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_gum_river_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_gum_river_red.init()

    return {
        description = "River red gum tree as decoration",
        depends = "tree_gum_river_red",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_eastern_coasts",
            "biome_australia_flinders_lofty",
            "biome_australia_great_dividing_range",
            "biome_australia_mulga_lands",
            "biome_australia_murray_darling_basin",
            "biome_australia_victorian_forests",
            "dirt_ordinary",
            "dirt_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_tree_gum_river_red.post()

    if unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil and
            unilib.pkg_executed_table["biome_australia_central_australia"] ~= nil then

        for i = 1, 4 do

            unilib.register_decoration_now("australia_tree_gum_river_red_in_central_" .. i, nil, {
                -- From australia/biome_central_australia.lua
                biomes = "australia_central_australia",
                place_on = "unilib:dirt_red_antipodean",
                y_max = 140,
                y_min = 36,
            })

        end

    elseif unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        if unilib.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil then

            for i = 1, 4 do

                unilib.register_decoration_now(
                    -- From australia/biome_eastern_coasts.lua
                    "australia_tree_gum_river_red_in_eastern_" .. i,
                    nil,
                    {
                        biomes = "australia_eastern_coasts",
                        place_on = "unilib:dirt_ordinary_with_turf",
                        y_max = 35,
                        y_min = 25,
                    }
                )

            end

        end
        if unilib.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil then

            for i = 1, 4 do

                unilib.register_decoration_now(
                    -- From australia/biome_flinders_lofty.lua
                    "australia_tree_gum_river_red_in_flinders_" .. i,
                    nil,
                    {
                        biomes = "australia_flinders_lofty",
                        place_on = "unilib:dirt_ordinary_with_turf_dry",
                        y_max = 140,
                        y_min = 36,
                    }
                )

            end

        end
        if unilib.pkg_executed_table["biome_australia_mulga_lands"] ~= nil then

            for i = 1, 4 do

                unilib.register_decoration_now(
                    -- From australia/biome_mulga_lands.lua
                    "australia_tree_gum_river_red_in_mulga_lands_" .. i,
                    nil,
                    {
                        biomes = "australia_mulga_lands",
                        place_on = "unilib:dirt_ordinary_with_turf_dry",
                        y_max = 140,
                        y_min = 36,
                    }
                )

            end

        end
        if unilib.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil then

            for i = 1, 4 do

                unilib.register_decoration_now(
                    -- From australia/biome_murray_darling_basin.lua
                    "australia_tree_gum_river_red_in_murray_" .. i,
                    nil,
                    {
                        biomes = "australia_murray_darling_basin",
                        place_on = "unilib:dirt_ordinary_with_turf_dry",
                        y_max = 140,
                        y_min = 36,
                    }
                )

            end

        end
        if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

            for i = 1, 4 do

                unilib.register_decoration_now(
                    -- From australia/biome_great_dividing_range.lua
                    "australia_tree_gum_river_red_in_range_" .. i,
                    nil,
                    {
                        biomes = "australia_great_dividing_range",
                        place_on = "unilib:dirt_ordinary_with_turf",
                        y_max = 140,
                        y_min = 36,
                    }
                )

            end

        end
        if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

            for i = 1, 4 do

                unilib.register_decoration_now(
                    -- From australia/biome_victorian_forests.lua
                    "australia_tree_gum_river_red_in_victoria_" .. i,
                    nil,
                    {
                        biomes = "australia_victorian_forests",
                        place_on = "unilib:dirt_ordinary_with_turf",
                        y_max = 140,
                        y_min = 36,
                    }
                )

            end

        end

    end

end
