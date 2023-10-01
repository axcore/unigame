---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/oak
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_oak_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.oak.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_oak_mature.init()

    return {
        description = "Mature oak tree as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "tree_oak_mature"},
    }

end

function unilib.pkg.deco_cool_trees_tree_oak_mature.post()

    unilib.register_decoration_now("cool_trees_tree_oak_mature", nil, {
        -- From oak/init.lua
        -- Completes decoration in package "tree_oak_mature"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 80,
        y_min = 1,
    })

end
