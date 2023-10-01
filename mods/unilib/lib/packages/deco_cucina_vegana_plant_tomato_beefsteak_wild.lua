---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_tomato_beefsteak_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_tomato_beefsteak_wild.init()

    return {
        description = "Wild beefsteak tomato plant as decoration",
        depends = "plant_tomato_beefsteak_wild",
        at_least_one = {"dirt_dry", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_tomato_beefsteak_wild.post()

    unilib.register_decoration_now("cucina_vegana_plant_tomato_beefsteak_wild", nil, {
        -- From cucina_vegana, tomato.lua
        -- Completes decoration in package "plant_tomato_beefsteak_wild"
        place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf"},
        y_max = 100,
        y_min = 0,
    })

end
