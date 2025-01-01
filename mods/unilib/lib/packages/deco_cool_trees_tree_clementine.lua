---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/clementinetree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_clementine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.clementinetree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_clementine.init()

    return {
        description = "Clementine tree as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "tree_clementine"},
    }

end

function unilib.pkg.deco_cool_trees_tree_clementine.post()

    unilib.register_decoration_complete("cool_trees_tree_clementine", nil, {
        -- From clementinetree/init.lua
        -- Completes decoration in package "tree_clementine"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 80,
        y_min = 1,
    })

end
