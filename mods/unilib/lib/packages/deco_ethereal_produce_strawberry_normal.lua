---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_strawberry_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_strawberry_normal.init()

    return {
        description = "Normal strawberry as decoration",
        depends = "produce_strawberry_normal",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_prairie"},
    }

end

function unilib.pkg.deco_ethereal_produce_strawberry_normal.post()

    unilib.register_decoration_complete("ethereal_produce_strawberry_normal", nil, {
        -- From ethereal-ng/schems.lua
        -- Completes decoration in package "produce_strawberry_normal"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_prairie"},
        y_max = 55,
        y_min = 15,
    })

end
