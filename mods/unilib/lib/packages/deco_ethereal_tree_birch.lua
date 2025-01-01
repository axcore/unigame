---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_birch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_birch.init()

    return {
        description = "Birch tree as decoration",
        depends = {"biome_ethereal_grassy", "dirt_ordinary", "tree_birch"},
    }

end

function unilib.pkg.deco_ethereal_tree_birch.post()

    unilib.register_decoration_complete("ethereal_tree_birch", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "tree_birch"
        biomes = "ethereal_grassy",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 100,
        y_min = 50,
    })

end
