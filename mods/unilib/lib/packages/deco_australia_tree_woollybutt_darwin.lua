---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_woollybutt_darwin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_woollybutt_darwin.init()

    return {
        description = "Darwin woollybutt tree as decoration",
        depends = "tree_woollybutt_darwin",
        optional = {
            "biome_australia_arnhem_land",
            "biome_australia_far_north_queensland",
            "biome_australia_gulf_of_carpentaria",
            "biome_australia_kimberley",
            "dirt_ordinary",
            "dirt_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_tree_woollybutt_darwin.post()

    if unilib.pkg_executed_table["biome_australia_arnhem_land"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now(
                -- From australia/biome_arnhem_land.lua
                "australia_tree_woollybutt_darwin_in_arnhem_" .. i,
                nil,
                {
                    biomes = "australia_arnhem_land",
                    place_on = "unilib:dirt_ordinary_with_turf",
                    y_max = 35,
                    y_min = 8,
                }
            )

        end

    end
    if unilib.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_woollybutt_darwin_in_gulf_" .. i, nil, {
                -- From australia/biome_gulf_of_carpentaria.lua
                biomes = "australia_gulf_of_carpentaria",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 35,
                y_min = 8,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_kimberley"] ~= nil and
            unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now(
                -- From australia/biome_kimberley.lua
                "australia_tree_woollybutt_darwin_in_kimberley_" .. i,
                nil,
                {
                    biomes = "australia_kimberley",
                    place_on = "unilib:dirt_red_antipodean",
                    y_max = 35,
                    y_min = 12,
                }
            )

        end

    end
    if unilib.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now(
                -- From australia/biome_far_north_queensland.lua
                "australia_tree_woollybutt_darwin_in_queensland_" .. i,
                nil,
                {
                    biomes = "australia_far_north_queensland",
                    place_on = "unilib:dirt_ordinary_with_turf",
                    y_max = 35,
                    y_min = 25,
                }
            )

        end

    end

end
