---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_plant_corn_ancient_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_plant_corn_ancient_wild.init()

    return {
        description = "Wild ancient corn as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary", "plant_corn_ancient_wild"},
    }

end

function unilib.pkg.deco_plants_plant_corn_ancient_wild.post()

    unilib.register_decoration_complete("plants_plant_corn_ancient_wild", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "plant_corn_ancient_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 60,
        y_min = 2,
    })

end
