---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bushes_bush_branching_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bushes_bush_branching_green.init()

    return {
        description = "Green branching bush as decoration",
        depends = {"bush_branching_green", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_bushes_bush_branching_green.post()

    unilib.register_decoration_complete("convert_bush_branching_green", nil, {
        -- From bushes/init.lua
        -- Completes decoration in package "bush_branching_green"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
