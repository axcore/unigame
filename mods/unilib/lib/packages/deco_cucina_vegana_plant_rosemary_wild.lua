---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_rosemary_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_rosemary_wild.init()

    return {
        description = "Wild rosemary plant as decoration",
        depends = "plant_rosemary_wild",
        at_least_one = {
            "dirt_ordinary",
            "liquid_water_ordinary",
            "liquid_water_river",
            "sand_ordinary",
            "sand_silver",
        },
    }

end

function unilib.pkg.deco_cucina_vegana_plant_rosemary_wild.post()

    unilib.register_decoration_now("cucina_vegana_plant_rosemary_wild", nil, {
        -- From cucina_vegana, rosemary.lua
        -- Completes decoration in package "plant_rosemary_wild"
        place_on = {
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:sand_ordinary",
            "unilib:sand_silver",
        },
        spawn_by = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},
        y_max = 50,
        y_min = 0,
    })

end
