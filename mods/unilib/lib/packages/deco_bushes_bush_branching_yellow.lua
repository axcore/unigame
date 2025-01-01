---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bushes_bush_branching_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bushes_bush_branching_yellow.init()

    return {
        description = "Yellow branching bush as decoration",
        depends = {"bush_branching_yellow", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_bushes_bush_branching_yellow.post()

    unilib.register_decoration_complete("convert_bush_branching_yellow", nil, {
        -- From bushes/init.lua
        -- Completes decoration in package "bush_branching_yellow"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
