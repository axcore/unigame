---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_bush_ordinary.init()

    return {
        description = "Alternative ordinary bush decoration from ethereal-ng",
        depends = {"bush_ordinary", "dirt_ordinary"},
        at_least_one = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
            "biome_ethereal_jumble",
        },
    }

end

function unilib.pkg.deco_ethereal_bush_ordinary.post()

    unilib.register_decoration_now("default_bush_ordinary", "ethereal_bush_ordinary", {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_ordinary"
        biomes = {
            "ethereal_forest_deciduous",
            "ethereal_grassy",
            "ethereal_jumble",
        },
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
