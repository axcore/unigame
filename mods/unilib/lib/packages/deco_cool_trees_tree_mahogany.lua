---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/mahogany
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_mahogany = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mahogany.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_mahogany.init()

    return {
        description = "Mahogany tree as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "tree_mahogany"},
    }

end

function unilib.pkg.deco_cool_trees_tree_mahogany.post()

    unilib.register_decoration_complete("cool_trees_tree_mahogany", nil, {
        -- From mahogany/init.lua
        -- Completes decoration in package "tree_mahogany"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = 62,
        y_min = 1,
    })

end
