---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_mineral_crystallinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_mineral_crystallinum.init()

    return {
        description = "Crystallinum and crystal shrubs as decoration",
        depends = {
            "biome_ethereal_frost",
            "dirt_ordinary_with_turf_crystal",
            "mineral_crystallinum",
            "plant_shrub_crystal",
        },
    }

end

function unilib.pkg.deco_ethereal_mineral_crystallinum.exec()

    unilib.register_decoration("ethereal_mineral_crystallinum", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {"unilib:mineral_crystallinum_spike", "unilib:plant_shrub_crystal"},

        fill_ratio = 0.02,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_mineral_crystallinum.post()

    unilib.register_decoration_now("ethereal_mineral_crystallinum", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {"ethereal_frost", "ethereal_frost_floatland"},
        place_on = "unilib:dirt_ordinary_with_turf_crystal",
        y_max = 1750,
        y_min = 1,
    })

end

