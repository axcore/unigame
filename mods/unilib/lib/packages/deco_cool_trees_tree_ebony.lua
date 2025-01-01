---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/ebony
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_ebony = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ebony.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_ebony.init()

    return {
        description = "Ebony tree as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "tree_ebony"},
    }

end

function unilib.pkg.deco_cool_trees_tree_ebony.post()

    unilib.register_decoration_complete("cool_trees_tree_ebony", nil, {
        -- From ebony/init.lua
        -- Completes decoration in package "tree_ebony"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = 62,
        y_min = 1,
    })

end
