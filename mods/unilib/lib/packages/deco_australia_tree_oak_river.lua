---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_oak_river = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_oak_river.init()

    return {
        description = "River oak tree as decoration",
        depends = {"dirt_ordinary", "tree_oak_river"},
        at_least_one = {
            "biome_australia_arnhem_land",
            "biome_australia_eastern_coasts",
            "biome_australia_far_north_queensland",
            "biome_australia_gulf_of_carpentaria",
            "biome_australia_mulga_lands",
        },
    }

end

function unilib.pkg.deco_australia_tree_oak_river.post()

    if unilib.pkg_executed_table["biome_australia_arnhem_land"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_oak_river_in_arnhem_" .. i, nil, {
                -- From australia/biome_arnhem_land.lua
                biomes = "australia_arnhem_land",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 12,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_oak_river_in_eastern_" .. i, nil, {
                -- From australia/biome_eastern_coasts.lua
                biomes = "australia_eastern_coasts",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 25,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_oak_river_in_gulf_" .. i, nil, {
                -- From australia/biome_gulf_of_carpentaria.lua
                biomes = "australia_gulf_of_carpentaria",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 35,
                y_min = 12,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_mulga_lands"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_oak_river_in_mulga_lands_" .. i, nil, {
                -- From australia/biome_mulga_lands.lua
                biomes = "australia_mulga_lands",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 150,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_far_north_queensland"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_oak_river_in_queensland_" .. i, nil, {
                -- From australia/biome_far_north_queensland.lua
                biomes = "australia_far_north_queensland",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 25,
            })

        end

    end

end
