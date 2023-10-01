---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bakedclay_flower_thistle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bakedclay_flower_thistle.init()

    return {
        description = "Thistle as decoration",
        depends = {"dirt_ordinary", "flower_thistle"},
    }

end

function unilib.pkg.deco_bakedclay_flower_thistle.exec()

    unilib.register_decoration_now("bakedclay_flower_thistle", nil, {
        -- From bakedclay/init.lua
        -- Completes decoration in package "flower_thistle"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_dry"},
        y_max = 90,
        y_min = 15,
    })

end
