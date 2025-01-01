---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_plantago = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_plantago.init()

    return {
        description = "Plantago as decoration",
        depends = {"dirt_ordinary", "flower_plantago"},
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_ethereal_mountain",
        },
    }

end

function unilib.pkg.deco_herbs_flower_plantago.post()

    unilib.register_decoration_complete("herbs_flower_plantago", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_plantago"
        biomes = {"default_forest_deciduous", "default_grassland", "ethereal_mountain"},
        place_on = {
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.constant.y_max,
        y_min = 50,
    })

end
