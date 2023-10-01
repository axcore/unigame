---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_spruce = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_spruce.init()

    return {
        description = "Spruce tree as decoration",
        depends = {"dirt_ordinary", "tree_spruce"},
    }

end

function unilib.pkg.deco_moretrees_tree_spruce.post()

    unilib.register_decoration_now("convert_tree_spruce", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_spruce"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 20,
    })

end

