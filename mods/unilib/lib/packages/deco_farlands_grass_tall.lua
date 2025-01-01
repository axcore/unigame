---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_tall = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_tall.init()

    return {
        description = "Tall grass as decoration",
        at_least_one = {
            {
                "biome_farlands_forest_coniferous",
                "biome_farlands_forest_deciduous",
                "biome_farlands_grassland",
                "biome_farlands_swamp",
            },
            {
                "dirt_ordinary",
                "dirt_ordinary_with_litter_leafy",
                "dirt_ordinary_with_turf_swamp",
            },
        },
    }

end

function unilib.pkg.deco_farlands_grass_tall.post()

    unilib.register_decoration_complete("farlands_grass_tall", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "grass_tall"
        biomes = {
            "farlands_forest_deciduous",
            "farlands_forest_coniferous_tall",
            "farlands_grassland",
            "farlands_swamp",
        },
        place_on = {
            "unilib:dirt_ordinary_with_litter_leafy",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_swamp",
        },
    })

end
