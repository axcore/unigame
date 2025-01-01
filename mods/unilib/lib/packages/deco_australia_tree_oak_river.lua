---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_oak_river = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_oak_river.init()

    return {
        description = "River oak tree as decoration",
        depends = "tree_oak_river",
        optional = {
            "biome_australia_arnhem_land",
            "biome_australia_eastern_coasts",
            "biome_australia_far_north_queensland",
            "biome_australia_gulf_of_carpentaria",
            "biome_australia_mulga_lands",
            "dirt_custom_antipodean",
            "dirt_ordinary",
        },
    }

end

function unilib.pkg.deco_australia_tree_oak_river.post()

    if unilib.global.pkg_executed_table["biome_australia_arnhem_land"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete("australia_tree_oak_river_in_arnhem_" .. i, nil, {
                -- From australia/biome_arnhem_land.lua
                biomes = "australia_arnhem_land",
                place_on = {
                    "unilib:dirt_ordinary_with_turf",
                    "unilib:dirt_antipodean_with_turf_arnhem_land",
                },
                y_max = 35,
                y_min = 12,
            })

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete("australia_tree_oak_river_in_eastern_" .. i, nil, {
                -- From australia/biome_eastern_coasts.lua
                biomes = "australia_eastern_coasts",
                place_on = {
                    "unilib:dirt_ordinary_with_turf",
                    "unilib:dirt_antipodean_with_turf_eastern_coasts",
                },
                y_max = 35,
                y_min = 25,
            })

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete("australia_tree_oak_river_in_gulf_" .. i, nil, {
                -- From australia/biome_gulf_of_carpentaria.lua
                biomes = "australia_gulf_of_carpentaria",
                place_on = {
                    "unilib:dirt_ordinary_with_turf_dry",
                    "unilib:dirt_ordinary_with_turf_gulf_of_carpentaria",
                },
                y_max = 35,
                y_min = 12,
            })

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_mulga_lands"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_mulga_lands.lua
                "australia_tree_oak_river_in_mulga_lands_" .. i,
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
    if unilib.global.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_far_north_queensland.lua
                "australia_tree_oak_river_in_queensland_" .. i,
                nil,
                {
                    biomes = "australia_far_north_queensland",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf",
                        "unilib:dirt_antipodean_with_turf_far_north_queensland",
                    },
                    y_max = 35,
                    y_min = 25,
                }
            )

        end

    end

end
