---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/willow
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_willow_mature = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.willow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_willow_mature.init()

    return {
        description = "Mature willow tree as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "tree_willow_mature"},
    }

end

function unilib.pkg.deco_cool_trees_tree_willow_mature.post()

    unilib.register_decoration_complete("cool_trees_tree_willow_mature", nil, {
        -- From willow/init.lua
        -- Completes decoration in package "tree_willow_mature"
        biomes = "default_forest_deciduous_shore",
        place_on = "unilib:dirt_ordinary",
        y_max = 62,
        y_min = -1,
    })

end
