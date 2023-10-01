---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_centaurea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_centaurea.init()

    return {
        description = "Centaurea as decoration",
        depends = {"dirt_ordinary", "flower_centaurea"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_herbs_flower_centaurea.post()

    unilib.register_decoration_now("herbs_flower_centaurea", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_centaurea"
        biomes = {"default_forest_deciduous", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
