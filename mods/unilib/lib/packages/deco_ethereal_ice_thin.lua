---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_ice_thin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_ice_thin.init()

    return {
        description = "Thin ice as decoration",
        depends = {"biome_ethereal_frost", "ice_thin", "sand_silver"},
    }

end

function unilib.pkg.deco_ethereal_ice_thin.exec()

    unilib.register_decoration_generic("ethereal_ice_thin", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:ice_thin",

        fill_ratio = 1,
        place_offset_y = 1,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_ice_thin.post()

    unilib.register_decoration_complete("ethereal_ice_thin", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "ice_thin"
        biomes = "ethereal_frost_ocean",
        place_on = "unilib:sand_silver",
        y_max = 0,
        y_min = 0,
    })

end
