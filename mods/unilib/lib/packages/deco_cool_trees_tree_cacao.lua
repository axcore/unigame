---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_cacao = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cacaotree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_cacao.init()

    return {
        description = "Cacao tree as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "tree_cacao"},
    }

end

function unilib.pkg.deco_cool_trees_tree_cacao.post()

    unilib.register_decoration_now("cool_trees_tree_cacao", nil, {
        -- From cacaotree/init.lua
        -- Completes decoration in package "tree_cacao"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
