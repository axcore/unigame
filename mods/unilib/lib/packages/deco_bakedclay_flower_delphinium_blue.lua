---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bakedclay_flower_delphinium_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bakedclay_flower_delphinium_blue.init()

    return {
        description = "Blue delphinium as decoration",
        depends = {"dirt_ordinary", "flower_delphinium_blue"},
    }

end

function unilib.pkg.deco_bakedclay_flower_delphinium_blue.post()

    unilib.register_decoration_complete("bakedclay_flower_delphinium_blue", nil, {
        -- From bakedclay/init.lua
        -- Completes decoration in package "flower_delphinium_blue"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 90,
        y_min = 10,
    })

end
