---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_oriental = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_bush_oriental.init()

    return {
        description = "Oriental bush as decoration",
        depends = {"biome_ethereal_bamboo", "bush_oriental", "dirt_ordinary_with_turf_bamboo"},
    }

end

function unilib.pkg.deco_ethereal_bush_oriental.post()

    unilib.register_decoration_now("ethereal_bush_oriental", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_oriental"
        biomes = "ethereal_bamboo",
        place_on = "unilib:dirt_ordinary_with_turf_bamboo",
        y_max = 100,
        y_min = 1,
    })

end
