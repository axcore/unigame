---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_chestnut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.chestnuttree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_chestnut.init()

    return {
        description = "Chestnut tree as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "tree_chestnut"},
    }

end

function unilib.pkg.deco_cool_trees_tree_chestnut.post()

    unilib.register_decoration_complete("cool_trees_tree_chestnut", nil, {
        -- From chestnuttree/init.lua
        -- Completes decoration in package "tree_chestnut"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 80,
        y_min = 1,
    })

end
