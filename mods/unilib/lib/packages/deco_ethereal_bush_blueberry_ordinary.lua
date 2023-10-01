---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_bush_blueberry_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_bush_blueberry_ordinary.init()

    return {
        description = "Alternative ordinary blueberry bush decoration from ethereal-ng",
        depends = {"bush_blueberry_ordinary", "dirt_ordinary"},
        at_least_one = {"biome_ethereal_forest_coniferous", "biome_ethereal_taiga"},
    }

end

function unilib.pkg.deco_ethereal_bush_blueberry_ordinary.post()

    unilib.register_decoration_now(
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "bush_blueberry_ordinary"
        "default_bush_blueberry_ordinary",
        "ethereal_bush_blueberry_ordinary",
        {
            biomes = {"ethereal_forest_coniferous", "ethereal_taiga"},
            place_on = {
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_cover_snow",
            },
            y_max = unilib.y_max,
            y_min = 1,
        }
    )

end
