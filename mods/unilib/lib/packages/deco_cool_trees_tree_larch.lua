---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/larch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_larch = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.larch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_larch.init()

    return {
        description = "Larch tree as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "tree_larch"},
    }

end

function unilib.pkg.deco_cool_trees_tree_larch.post()

    unilib.register_decoration_now("cool_trees_tree_larch", nil, {
        -- From larch/init.lua
        -- Completes decoration in package "tree_larch"
        biomes = "default_forest_coniferous",
        place_on = "unilib:dirt_ordinary_with_litter_coniferous",
        y_max = 32,
        y_min = 1,
    })

end
