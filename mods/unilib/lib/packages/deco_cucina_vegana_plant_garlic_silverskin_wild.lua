---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_garlic_silverskin_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_garlic_silverskin_wild.init()

    return {
        description = "Wild silverskin garlic plant as decoration",
        depends = {"dirt_ordinary", "plant_garlic_silverskin_wild"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_garlic_silverskin_wild.post()

    unilib.register_decoration_now("cucina_vegana_plant_garlic_silverskin_wild", nil, {
        -- From cucina_vegana, garlic.lua
        -- Completes decoration in package "plant_garlic_silverskin_wild"
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"},
        y_max = 100,
        y_min = 0,
    })

end
