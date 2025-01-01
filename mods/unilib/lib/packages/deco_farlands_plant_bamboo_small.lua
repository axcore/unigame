---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_bamboo_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_bamboo_small.init()

    return {
        description = "Small bamboo plant as decoration",
        depends = {"biome_farlands_forest_bamboo", "dirt_ordinary", "plant_bamboo_small"},
    }

end

function unilib.pkg.deco_farlands_plant_bamboo_small.post()

    unilib.register_decoration_complete("farlands_plant_bamboo_small_mini", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_bamboo_small"
        biomes = "farlands_forest_bamboo",
        place_on = "unilib:dirt_ordinary_with_turf",
        -- (no y_max)
        -- (no y_min)
    })

    unilib.register_decoration_complete("farlands_plant_bamboo_small", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_bamboo_small"
        biomes = "farlands_forest_bamboo",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
