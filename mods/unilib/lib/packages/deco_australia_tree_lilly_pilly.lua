---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_lilly_pilly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_lilly_pilly.init()

    return {
        description = "Lilly Pilly tree as decoration",
        depends = "tree_lilly_pilly",
        optional = {
            "biome_australia_eastern_coasts",
            "biome_australia_far_north_queensland",
            "biome_australia_great_dividing_range",
            "biome_australia_victorian_forests",
            "dirt_custom_antipodean",
            "dirt_ordinary",
        },
    }

end

function unilib.pkg.deco_australia_tree_lilly_pilly.post()

    if unilib.global.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_eastern_coasts.lua
                "australia_tree_lilly_pilly_in_eastern_" .. i,
                nil,
                {
                    biomes = "australia_eastern_coasts",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf",
                        "unilib:dirt_antipodean_with_turf_eastern_coasts",
                    },
                    y_max = 35,
                    y_min = 7,
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
                "australia_tree_lilly_pilly_in_queensland_" .. i,
                nil,
                {
                    biomes = "australia_far_north_queensland",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf",
                        "unilib:dirt_antipodean_with_turf_far_north_queensland",
                    },
                    y_max = 35,
                    y_min = 20,
                }
            )

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete("australia_tree_lilly_pilly_in_range_" .. i, nil, {
                -- From australia/biome_great_dividing_range.lua
                biomes = "australia_great_dividing_range",
                place_on = {
                    "unilib:dirt_ordinary_with_turf",
                    "unilib:dirt_antipodean_with_turf_great_dividing_range",
                },
                y_max = 150,
                y_min = 36,
            })

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_victorian_forests"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_victorian_forests.lua
                "australia_tree_lilly_pilly_in_victoria_" .. i,
                nil,
                {
                    biomes = "australia_victorian_forests",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf",
                        "unilib:dirt_antipodean_dark_with_turf_victorian_forests",
                    },
                    y_max = 150,
                    y_min = 36,
                }
            )

        end

    end

end
