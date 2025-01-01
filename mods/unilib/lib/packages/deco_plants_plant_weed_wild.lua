---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_plant_weed_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_plant_weed_wild.init()

    return {
        description = "Wild weed as decoration",
        depends = {"dirt_ordinary", "plant_weed_wild"},
    }

end

function unilib.pkg.deco_plants_plant_weed_wild.post()

    unilib.register_decoration_complete("plants_plant_weed_wild", nil, {
        -- Original to unilib
        -- Completes decoration in package "plant_weed_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 60,
        y_min = 2,
    })

end
