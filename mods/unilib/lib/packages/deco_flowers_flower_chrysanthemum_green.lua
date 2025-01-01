---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_flowers_flower_chrysanthemum_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_flowers_flower_chrysanthemum_green.init()

    return {
        description = "Green chrysanthemum as decoration",
        depends = {"dirt_ordinary", "flower_chrysanthemum_green"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_flowers_flower_chrysanthemum_green.post()

    unilib.register_decoration_complete("flowers_flower_chrysanthemum_green", nil, {
        -- From flowers/mapgen.lua
        -- Completes decoration in package "flower_chrysanthemum_green"
        biomes = {"default_forest_deciduous", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
