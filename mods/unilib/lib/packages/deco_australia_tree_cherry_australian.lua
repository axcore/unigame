---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_cherry_australian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_cherry_australian.init()

    return {
        description = "Australian cherry tree as decoration",
        depends = "tree_cherry_australian",
        optional = {
            "biome_australia_eastern_coasts",
            "biome_australia_flinders_lofty",
            "biome_australia_great_dividing_range",
            "dirt_custom_antipodean",
            "dirt_ordinary",
        },
    }

end

function unilib.pkg.deco_australia_tree_cherry_australian.post()

    if unilib.global.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_eastern_coasts.lua
                "australia_tree_cherry_australian_in_eastern_" .. i,
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
    if unilib.global.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            -- N.B. In "great_dividing_range" biome in original code, but that is an obvious mistake
            unilib.register_decoration_complete(
                -- From australia/biome_flinders_lofty.lua
                "australia_tree_cherry_australian_in_flinders_" .. i,
                nil,
                {
                    biomes = "australia_flinders_lofty",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf_dry",
                        "unilib:dirt_ordinary_with_turf_flinders_lofty",
                    },
                    y_max = 120,
                    y_min = 36,
                }
            )

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        for i = 1, 2 do

            unilib.register_decoration_complete(
                -- From australia/biome_great_dividing_range.lua
                "australia_tree_cherry_australian_in_range_" .. i,
                nil,
                {
                    biomes = "australia_great_dividing_range",
                    place_on = {
                        "unilib:dirt_ordinary_with_turf",
                        "unilib:dirt_antipodean_with_turf_great_dividing_range",
                    },
                    y_max = 150,
                    y_min = 36,
                }
            )

        end

    end

end
