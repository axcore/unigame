---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/pomegranate
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_pomegranate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pomegranate.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_pomegranate.init()

    return {
        description = "Pomegranate tree as decoration",
        depends = {"biome_default_savanna", "dirt_dry", "tree_pomegranate"},
    }

end

function unilib.pkg.deco_cool_trees_tree_pomegranate.post()

    unilib.register_decoration_complete("cool_trees_tree_pomegranate", nil, {
        -- From pomegranate/init.lua
        -- Completes decoration in package "tree_pomegranate"
        biomes = "default_savanna",
        place_on = "unilib:dirt_dry",
        y_max = 80,
        y_min = 1,
    })

end
