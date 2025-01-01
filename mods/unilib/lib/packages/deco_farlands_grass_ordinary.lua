---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_ordinary.init()

    return {
        description = "Ordinary grass as decoration",
        depends = "grass_ordinary",
        at_least_one = {
            {
                "biome_farlands_forest_coniferous",
                "biome_farlands_forest_deciduous",
                "biome_farlands_grassland",
            },
            {"dirt_ordinary", "dirt_ordinary_with_litter_leafy", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_farlands_grass_ordinary.post()

    for i = 1, 5 do

        unilib.register_decoration_complete(
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "grass_ordinary"
            "default_grass_ordinary_" .. i,
            "farlands_grass_ordinary_" .. i,
            {
                biomes = {
                    "farlands_forest_deciduous",
                    "farlands_forest_coniferous",
                    "farlands_forest_coniferous_beach",
                    "farlands_forest_coniferous_tall",
                    "farlands_grassland",
                    "farlands_grassland_beach",
                },
                place_on = {
                    "unilib:dirt_ordinary_with_litter_leafy",
                    "unilib:dirt_ordinary_with_turf",
                    "unilib:sand_ordinary",
                },
                y_max = unilib.constant.y_max,
                y_min = 1,
            }
        )

    end

end
