---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_oriental = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

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

    unilib.register_decoration_complete("ethereal_bush_oriental", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_oriental"
        biomes = "ethereal_bamboo",
        num_spawn_by = 6,
        place_on = "unilib:dirt_ordinary_with_turf_bamboo",
        spawn_by = "unilib:dirt_ordinary_with_turf_bamboo",
        y_max = 70,
        y_min = 35,
    })

end
