---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/maple
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_maple_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maple.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_maple_red.init()

    return {
        description = "Red maple tree as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "tree_maple_red"},
    }

end

function unilib.pkg.deco_cool_trees_tree_maple_red.post()

    unilib.register_decoration_now("cool_trees_tree_maple_red", nil, {
        -- From maple/init.lua
        -- Completes decoration in package "tree_maple_red"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 62,
        y_min = 1,
    })

end
