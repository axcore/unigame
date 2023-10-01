---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_youngtrees_tree_young_bamboo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.youngtrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_youngtrees_tree_young_bamboo.init()

    return {
        description = "Young bamboo tree as decoration",
        depends = {"dirt_ordinary", "tree_young_bamboo"},
    }

end

function unilib.pkg.deco_youngtrees_tree_young_bamboo.exec()

    unilib.register_decoration_now("convert_tree_young_bamboo", nil, {
        -- From bushes/init.lua
        -- Completes decoration in package "tree_young_bamboo"
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf_bamboo",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
