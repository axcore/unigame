---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_herbs_flower_leontopodium_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_herbs_flower_leontopodium_white.init()

    return {
        description = "White leontopodium as decoration",
        depends = {"dirt_ordinary", "flower_leontopodium_white"},
        at_least_one = {"biome_default_grassland", "biome_ethereal_mountain"},
    }

end

function unilib.pkg.deco_herbs_flower_leontopodium_white.post()

    unilib.register_decoration_complete("herbs_flower_leontopodium_white", nil, {
        -- From herbs/mapgen.lua
        -- Completes decoration in package "flower_leontopodium_white"
        biomes = {"default_grassland", "ethereal_mountain"},
        place_on = {
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.constant.y_max,
        y_min = 70,
    })

end
