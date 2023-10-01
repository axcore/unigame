---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_olive = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_olive.init()

    return {
        description = "Olive tree as decoration",
        depends = {"biome_ethereal_mediterranean", "dirt_ordinary_with_turf_grove", "tree_olive"},
    }

end

function unilib.pkg.deco_ethereal_tree_olive.post()

    unilib.register_decoration_now("ethereal_tree_olive", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_olive"
        biomes = "ethereal_mediterranean",
        place_on = "unilib:dirt_ordinary_with_turf_grove",
        y_max = 35,
        y_min = 5,
    })

end

