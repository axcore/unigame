---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_banana = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_banana.init()

    return {
        description = "Banana tree as decoration",
        depends = {"biome_ethereal_grove", "dirt_ordinary_with_turf_grove", "tree_banana"},
    }

end

function unilib.pkg.deco_ethereal_tree_banana.post()

    unilib.register_decoration_now("ethereal_tree_banana", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_banana"
        biomes = "ethereal_grove",
        place_on = "unilib:dirt_ordinary_with_turf_grove",
        y_max = 100,
        y_min = 1,
    })

end

