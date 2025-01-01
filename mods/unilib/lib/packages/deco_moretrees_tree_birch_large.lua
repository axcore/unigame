---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_birch_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_birch_large.init()

    return {
        description = "Large birch tree as decoration",
        depends = {"dirt_ordinary", "tree_birch_large"},
    }

end

function unilib.pkg.deco_moretrees_tree_birch_large.post()

    unilib.register_decoration_complete("convert_tree_birch_large", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_birch_large"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 15,
        y_min = 10,
    })

end
