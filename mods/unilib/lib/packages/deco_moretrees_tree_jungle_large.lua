---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_jungle_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_jungle_large.init()

    return {
        description = "Large jungle tree as decoration",
        depends = {"dirt_ordinary", "tree_jungle", "tree_jungle_large"},
    }

end

function unilib.pkg.deco_moretrees_tree_jungle_large.post()

    -- N.B. In order to make large jungle trees grow in actual jungle biomes (such as those
    --      imported from minetest_game), we don't check surrounding space, and only grow on
    --      rainforest litter
    unilib.register_decoration_now("convert_tree_jungle_large", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_jungle_large"
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        spawn_by = "unilib:tree_jungle_trunk",
        y_max = unilib.y_max,
        y_min = 1,
    })

end

