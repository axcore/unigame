---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_onion_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_onion_wild.init()

    return {
        description = "Wild onion as decoration",
        depends = "produce_onion_wild",
        at_least_one = {
            {
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_jumble",
                "biome_ethereal_prairie",
            },
            {"dirt_ordinary", "dirt_ordinary_with_turf_prairie"},
        },
    }

end

function unilib.pkg.deco_ethereal_produce_onion_wild.post()

    unilib.register_decoration_now("ethereal_produce_onion_wild", nil, {
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "produce_onion_wild"
        biomes = {
            "ethereal_forest_deciduous",
            "ethereal_grassy",
            "ethereal_jumble",
            "ethereal_prairie",
        },
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_prairire"},
        y_max = 100,
        y_min = 1,
    })

end

