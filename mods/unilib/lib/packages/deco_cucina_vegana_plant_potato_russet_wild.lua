---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_potato_russet_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_potato_russet_wild.init()

    return {
        description = "Wild russet potato plant as decoration",
        depends = "plant_potato_russet_wild",
        at_least_one = {"dirt_dry", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_potato_russet_wild.post()

    unilib.register_decoration_complete("cucina_vegana_plant_potato_russet_wild", nil, {
        -- From cucina_vegana, potato.lua
        -- Completes decoration in package "plant_potato_russet_wild"
        place_on = {
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = 100,
        y_min = 0,
    })

end
