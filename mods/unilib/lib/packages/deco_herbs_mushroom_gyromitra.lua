---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_mushroom_gyromitra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_mushroom_gyromitra.init()

    return {
        description = "Gyromitra mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_gyromitra"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
        },
    }

end

function unilib.pkg.deco_herbs_mushroom_gyromitra.post()

    unilib.register_decoration_now("herbs_mushroom_gyromitra", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "mushroom_gyromitra"
        biomes = {"default_forest_coniferous", "default_forest_deciduous", "default_rainforest"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end

