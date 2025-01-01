---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_spore = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_spore.init()

    return {
        description = "Spore grass as decoration",
        depends = {"biome_ethereal_mushroom", "dirt_ordinary_with_turf_mushroom", "grass_spore"},
    }

end

function unilib.pkg.deco_ethereal_grass_spore.post()

    unilib.register_decoration_complete("ethereal_grass_spore", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "grass_spore"
        biomes = "ethereal_mushroom",
        place_on = "unilib:dirt_ordinary_with_turf_mushroom",
        y_max = 100,
        y_min = 1,
    })

end
