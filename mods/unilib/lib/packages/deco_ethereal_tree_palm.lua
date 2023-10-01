---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_palm = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_palm.init()

    return {
        description = "Palm tree as decoration",
        depends = {"sand_ordinary", "tree_palm"},
        at_least_one = {
            "biome_ethereal_desert",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grove",
            "biome_ethereal_mesa",
            "biome_ethereal_plains",
            "biome_ethereal_sand_clay",
            "biome_ethereal_sandstone",
        },
    }

end

function unilib.pkg.deco_ethereal_tree_palm.post()

    unilib.register_decoration_now("ethereal_tree_palm", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_palm"
        biomes = {
            "ethereal_desert_ocean",
            "ethereal_forest_deciduous_ocean",
            "ethereal_grove_ocean",
            "ethereal_mesa_ocean",
            "ethereal_plains_ocean",
            "ethereal_sand_clay",
            "ethereal_sandstone_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = 1,
        y_min = 1,
    })

end
