---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_quandong_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_quandong_desert.init()

    return {
        description = "Desert quandong tree as decoration",
        depends = "tree_quandong_desert",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_goldfields_esperance",
            "biome_australia_mulga_lands",
            "biome_australia_murray_darling_basin",
            "biome_australia_simpson_desert",
            "dirt_ordinary",
            "dirt_red_antipodean",
            "sand_desert",
            "sand_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_tree_quandong_desert.post()

    if unilib.global.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.global.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_central_australia.lua
                "australia_tree_quandong_desert_in_central_" .. i,
                nil,
                {
                    biomes = "australia_central_australia",
                    place_on = "unilib:dirt_red_antipodean",
                    y_max = 130,
                    y_min = 36,
                }
            )

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_goldfields_esperance"] ~= nil and
            unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_goldfields_esperence.lua
                "australia_tree_quandong_desert_in_goldfields_" .. i,
                nil,
                {
                    biomes = "australia_goldfields_esperance",
                    place_on = "unilib:sand_desert",
                    y_max = 35,
                    y_min = 6,
                }
            )

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_mulga_lands"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_mulga_lands.lua
                "australia_tree_quandong_desert_in_mulga_lands_" .. i,
                nil,
                {
                    biomes = "australia_mulga_lands",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf_dry",
                        "unilib:dirt_ordinary_with_turf_mulga_lands",
                    },
                    y_max = 150,
                    y_min = 36,
                }
            )

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_murray_darling_basin.lua
                "australia_tree_quandong_desert_in_murray_" .. i,
                nil,
                {
                    biomes = "australia_murray_darling_basin",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf_dry",
                        "unilib:dirt_ordinary_with_turf_murray_darling_basin",
                    },
                    y_max = 150,
                    y_min = 36,
                }
            )

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_simpson_desert"] ~= nil and
            unilib.global.pkg_executed_table["sand_red_antipodean"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_simpson_desert.lua
                "australia_tree_quandong_desert_in_simpson_" .. i,
                nil,
                {
                    biomes = "australia_simpson_desert",
                    place_on = "unilib:sand_red_antipodean",
                    y_max = 130,
                    y_min = 36,
                }
            )

        end

    end

end
