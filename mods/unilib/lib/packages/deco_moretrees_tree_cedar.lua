---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_cedar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_cedar.init()

    return {
        description = "Cedar tree as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary", "tree_cedar"},
    }

end

function unilib.pkg.deco_moretrees_tree_cedar.post()

    unilib.register_decoration_now("convert_tree_cedar", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_cedar"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = unilib.y_max,
        y_min = 0,
    })

end
