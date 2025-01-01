---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_chives_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_chives_wild.init()

    return {
        description = "Wild chives plant as decoration",
        depends = {"dirt_ordinary", "plant_chives_wild"},
        at_least_one = {"liquid_water_ordinary", "liquid_water_river"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_chives_wild.post()

    unilib.register_decoration_complete("cucina_vegana_plant_chives_wild", nil, {
        -- From cucina_vegana, chives.lua
        -- Completes decoration in package "plant_chives_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},
        y_max = 150,
        y_min = 0,
    })

end
