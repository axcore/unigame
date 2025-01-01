---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_plant_tansy_common = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_plant_tansy_common.init()

    return {
        description = "Common tansy as decoration",
        depends = {"dirt_ordinary", "plant_tansy_common"},
    }

end

function unilib.pkg.deco_plants_plant_tansy_common.post()

    unilib.register_decoration_complete("plants_plant_tansy_common", nil, {
        -- Original to unilib
        -- Completes decoration in package "plant_tansy_common"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 60,
        y_min = 2,
    })

end

