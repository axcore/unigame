---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_youngtrees_tree_young_apple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.youngtrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_youngtrees_tree_young_apple.init()

    return {
        description = "Young apple tree as decoration",
        depends = {"dirt_ordinary", "tree_young_apple"},
    }

end

function unilib.pkg.deco_youngtrees_tree_young_apple.post()

    unilib.register_decoration_complete("convert_tree_young_apple", nil, {
        -- From bushes/init.lua
        -- Completes decoration in package "tree_young_apple"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
