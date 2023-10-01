---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cherrytree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_cherry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cherrytree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_cherry.init()

    return {
        description = "Cherry tree as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "tree_cherry"},
    }

end

function unilib.pkg.deco_cool_trees_tree_cherry.post()

    unilib.register_decoration_now("cool_trees_tree_cherry", nil, {
        -- From cherrytree/init.lua
        -- Completes decoration in package "tree_cherry"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 32,
        y_min = 1,
    })

end
