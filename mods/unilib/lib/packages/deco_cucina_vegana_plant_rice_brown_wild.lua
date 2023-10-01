---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_rice_brown_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_rice_brown_wild.init()

    return {
        description = "Wild brown rice plant as decoration",
        depends = {"dirt_ordinary", "plant_rice_brown_wild"},
        at_least_one = {
            "liquid_water_ordinary",
            "liquid_water_river",
            "plant_papyrus_ordinary",
            "tree_jungle",
        },
    }

end

function unilib.pkg.deco_cucina_vegana_plant_rice_brown_wild.post()

    unilib.register_decoration_now("cucina_vegana_plant_rice_brown_wild", nil, {
        -- From cucina_vegana, rice.lua
        -- Completes decoration in package "plant_rice_brown_wild"
        place_on = {
            "unilib:dirt_ordinary",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        spawn_by = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_water_ordinary_flowing",
            "unilib:liquid_water_river_source",
            "unilib:liquid_water_river_source",
            "unilib:plant_papyrus_ordinary",
            "unilib:tree_jungle_trunk",
        },
        y_max = 50,
        y_min = -5,
    })

end
