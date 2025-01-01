---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/lemontree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_lemon_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.lemontree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_lemon_mature.init()

    return {
        description = "Mature lemon tree as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "tree_lemon_mature"},
    }

end

function unilib.pkg.deco_cool_trees_tree_lemon_mature.post()

    unilib.register_decoration_complete("cool_trees_tree_lemon_mature", nil, {
        -- From lemontree/init.lua
        -- Completes decoration in package "tree_lemon_mature"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 80,
        y_min = 1,
    })

end
