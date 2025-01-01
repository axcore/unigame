---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_bush_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_bush_exotic.init()

    return {
        description = "Exotic bush as decoration",
        depends = {"biome_farlands_forest_bamboo", "bush_exotic", "dirt_ordinary"},
        optional = {
            "biome_farlands_forest_coniferous",
            "biome_farlands_forest_deciduous",
            "biome_farlands_grassland",
            "biome_farlands_grassland_snowy",
        },
    }

end

function unilib.pkg.deco_farlands_bush_exotic.post()

    unilib.register_decoration_complete("farlands_bush_exotic_1", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "bush_exotic"
        biomes = {
            "farlands_forest_bamboo",
            "farlands_forest_coniferous_tall",
            "farlands_forest_deciduous",
            "farlands_grassland",
            "farlands_grassland_snowy",
        },
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

    unilib.register_decoration_complete("farlands_bush_exotic_2", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "bush_exotic"
        biomes = "farlands_forest_bamboo",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end

