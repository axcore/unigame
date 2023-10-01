---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_kelp_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_kelp_ordinary.init()

    return {
        description = "Ordinary sand with kelp as decoration",
        depends = {"plant_kelp_ordinary", "sand_ordinary"},
        at_least_one = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_frost",
            "biome_ethereal_sandstone",
            "biome_ethereal_swamp",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_kelp_ordinary.post()

    unilib.register_decoration_now(
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "plant_kelp_ordinary"
        "default_plant_kelp_ordinary",
        "ethereal_plant_kelp_ordinary",
        {
            biomes = {
                "ethereal_forest_deciduous_ocean",
                "ethereal_frost_ocean",
                "ethereal_sandstone_ocean",
                "ethereal_swamp_ocean",
            },
            place_on = "unilib:sand_ordinary",
            y_max = -5,
            y_min = -10,
        }
    )

end

