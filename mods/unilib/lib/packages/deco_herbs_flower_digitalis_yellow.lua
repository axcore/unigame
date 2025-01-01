---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_digitalis_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_digitalis_yellow.init()

    return {
        description = "Yellow digitalis as decoration",
        depends = {"dirt_ordinary", "flower_digitalis_yellow"},
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_rainforest",
        },
    }

end

function unilib.pkg.deco_herbs_flower_digitalis_yellow.post()

    unilib.register_decoration_complete("herbs_flower_digitalis_yellow", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_digitalis_yellow"
        biomes = {"default_forest_deciduous_shore", "default_grassland", "default_rainforest"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
