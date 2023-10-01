---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_flowers_flower_dandelion_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_flowers_flower_dandelion_yellow.init()

    return {
        description = "Yellow dandelion as decoration",
        depends = {"dirt_ordinary", "flower_dandelion_yellow"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_flowers_flower_dandelion_yellow.post()

    unilib.register_decoration_now("flowers_flower_dandelion_yellow", nil, {
        -- From flowers/mapgen.lua
        -- Completes decoration in package "flower_dandelion_yellow"
        biomes = {"default_forest_deciduous", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
