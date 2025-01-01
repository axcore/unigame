---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_orange.init()

    return {
        description = "Orange tree as decoration",
        depends = {"biome_ethereal_prairie", "dirt_ordinary_with_turf_prairie", "tree_orange"},
    }

end

function unilib.pkg.deco_ethereal_tree_orange.post()

    unilib.register_decoration_complete("ethereal_tree_orange", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_orange"
        biomes = "ethereal_prairie",
        place_on = "unilib:dirt_ordinary_with_turf_prairie",
        y_max = 100,
        y_min = 1,
    })

end
