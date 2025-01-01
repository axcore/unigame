---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_soy_red_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_soy_red_wild.init()

    return {
        description = "Wild red soy plant as decoration",
        depends = {"dirt_ordinary", "plant_soy_red_wild"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_soy_red_wild.post()

    unilib.register_decoration_complete("cucina_vegana_plant_soy_red_wild", nil, {
        -- From cucina_vegana, soy.lua
        -- Completes decoration in package "plant_soy_red_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 90,
        y_min = 10,
    })

end
