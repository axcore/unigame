---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_lilac = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_lilac.init()

    return {
        description = "Flower as decoration",
        depends = {"biome_ethereal_bamboo", "dirt_ordinary_with_turf_bamboo", "flower_lilac"},
    }

end

function unilib.pkg.deco_ethereal_flower_lilac.post()

    unilib.register_decoration_complete("ethereal_flower_lilac", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "flower_lilac"
        biomes = "ethereal_bamboo",
        place_on = "unilib:dirt_ordinary_with_turf_bamboo",
        y_max = 35,
        y_min = 3,
    })

end
