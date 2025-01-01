---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/hollytree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_holly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.hollytree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_holly.init()

    return {
        description = "Holly tree as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "tree_holly"},
    }

end

function unilib.pkg.deco_cool_trees_tree_holly.post()

    unilib.register_decoration_complete("cool_trees_tree_holly", nil, {
        -- From hollytree/init.lua
        -- Completes decoration in package "tree_holly"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 32,
        y_min = 1,
    })

end
