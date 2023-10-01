---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/baldcypress
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cool_trees_tree_cypress_bald = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.baldcypress.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cool_trees_tree_cypress_bald.init()

    return {
        description = "Bald cypress tree as decoration",
        depends = {"biome_default_forest_coniferous", "sand_ordinary", "tree_cypress_bald"},
    }

end

function unilib.pkg.deco_cool_trees_tree_cypress_bald.post()

    unilib.register_decoration_now("cool_trees_tree_cypress_bald", nil, {
        -- From baldcypress/init.lua
        -- Completes decoration in package "tree_cypress_bald"
        biomes = "default_forest_coniferous_ocean",
        place_on = "unilib:sand_ordinary",
        y_max = 0,
        y_min = 0,
    })

end
