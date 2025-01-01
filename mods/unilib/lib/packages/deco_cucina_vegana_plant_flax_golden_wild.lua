---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_flax_golden_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_flax_golden_wild.init()

    return {
        description = "Wild golden flax plant as decoration",
        depends = "plant_flax_golden_wild",
        at_least_one = {"dirt_dry", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_flax_golden_wild.post()

    unilib.register_decoration_complete("cucina_vegana_plant_flax_golden_wild", nil, {
        -- From cucina_vegana, flax.lua
        -- Completes decoration in package "plant_flax_golden_wild"
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_dry_with_turf_dry"},
        y_max = 100,
        y_min = 0,
    })

end
