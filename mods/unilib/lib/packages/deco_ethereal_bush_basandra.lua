---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_basandra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_bush_basandra.init()

    return {
        description = "Basandra bush as decoration",
        depends = {"biome_ethereal_fiery", "bush_basandra", "dirt_ordinary_with_turf_fiery"},
    }

end

function unilib.pkg.deco_ethereal_bush_basandra.post()

    unilib.register_decoration_complete("ethereal_bush_basandra", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_basandra"
        biomes = "ethereal_fiery",
        place_on = "unilib:dirt_ordinary_with_turf_fiery",
        y_max = 100,
        y_min = 1,
    })

end
