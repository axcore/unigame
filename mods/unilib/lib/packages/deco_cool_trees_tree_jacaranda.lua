---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/jacaranda
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_jacaranda = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.jacaranda.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_jacaranda.init()

    return {
        description = "Jacaranda tree as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "tree_jacaranda"},
    }

end

function unilib.pkg.deco_cool_trees_tree_jacaranda.post()

    unilib.register_decoration_complete("cool_trees_tree_jacaranda", nil, {
        -- From jacaranda/init.lua
        -- Completes decoration in package "tree_jacaranda"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = 32,
        y_min = 1,
    })

end
