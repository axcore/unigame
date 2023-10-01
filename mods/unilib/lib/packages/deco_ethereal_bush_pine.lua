---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_pine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_bush_pine.init()

    return {
        description = "Alternative pine bush decoration from ethereal-ng",
        depends = {"bush_pine", "biome_ethereal_taiga", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_bush_pine.post()

    unilib.register_decoration_now("default_bush_pine", "etheral_bush_pine", {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_pine"
        biomes = "ethereal_taiga",
        place_on = "unilib:dirt_ordinary_with_cover_snow",
        y_max = unilib.y_max,
        y_min = 4,
    })

end
