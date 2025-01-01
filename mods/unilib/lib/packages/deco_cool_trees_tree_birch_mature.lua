---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/birch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_birch_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.birch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_birch_mature.init()

    return {
        description = "Mature birch tree as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "tree_birch_mature"},
    }

end

function unilib.pkg.deco_cool_trees_tree_birch_mature.post()

    unilib.register_decoration_complete("cool_trees_tree_birch_mature", nil, {
        -- From birch/init.lua
        -- Completes decoration in package "tree_birch_mature"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 80,
        y_min = 1,
    })

end
