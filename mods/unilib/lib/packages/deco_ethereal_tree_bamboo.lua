---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_bamboo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_bamboo.init()

    return {
        description = "Bamboo tree as decoration",
        depends = {"biome_ethereal_bamboo", "dirt_ordinary_with_turf_bamboo", "tree_bamboo"},
    }

end

function unilib.pkg.deco_ethereal_tree_bamboo.post()

    unilib.register_decoration_complete("ethereal_tree_bamboo", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_bamboo"
        biomes = "ethereal_bamboo",
        place_on = "unilib:dirt_ordinary_with_turf_bamboo",
        y_max = 70,
        y_min = 36,
    })

end
