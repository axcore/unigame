---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_shrub_banana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_shrub_banana.init()

    return {
        description = "Banana plant as decoration",
        depends = {
            "biome_farlands_rainforest",
            "dirt_ordinary_with_turf_forest",
            "plant_shrub_banana",
        },
    }

end

function unilib.pkg.deco_farlands_plant_shrub_banana.post()

    unilib.register_decoration_complete("farlands_plant_shrub_banana", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_shrub_banana"
        biomes = "farlands_rainforest",
        place_on = "unilib:dirt_ordinary_with_turf_forest",
    })

end
