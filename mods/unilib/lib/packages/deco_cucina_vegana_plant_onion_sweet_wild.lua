---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_onion_sweet_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_onion_sweet_wild.init()

    return {
        description = "Wild sweet onion plant as decoration",
        depends = {"dirt_ordinary", "plant_onion_sweet_wild"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_onion_sweet_wild.post()

    unilib.register_decoration_now("cucina_vegana_plant_onion_sweet_wild", nil, {
        -- From cucina_vegana, onion.lua
        -- Completes decoration in package "plant_onion_sweet_wild"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 150,
        y_min = 0,
    })

end
