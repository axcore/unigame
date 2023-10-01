---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_acacia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_bush_acacia.init()

    return {
        description = "Alternative acacia bush decoration from ethereal-ng",
        depends = "bush_acacia",
        at_least_one = {
            {"biome_ethereal_mesa", "biome_ethereal_savanna"},
            {"dirt_dry", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_ethereal_bush_acacia.post()

    unilib.register_decoration_now("default_bush_acacia", "ethereal_bush_acacia", {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_acacia"
        biomes = {"ethereal_mesa", "ethereal_savanna"},
        place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf_dry"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
