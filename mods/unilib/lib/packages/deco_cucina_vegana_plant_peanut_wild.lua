---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_peanut_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_peanut_wild.init()

    return {
        description = "Wild peanut plant as decoration",
        depends = {"dirt_ordinary", "plant_peanut_wild"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_peanut_wild.post()

    unilib.register_decoration_complete("cucina_vegana_plant_peanut_wild", nil, {
        -- From cucina_vegana, peanut.lua
        -- Completes decoration in package "plant_peanut_wild"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_dry"},
        y_max = 150,
        y_min = 20,
    })

end
