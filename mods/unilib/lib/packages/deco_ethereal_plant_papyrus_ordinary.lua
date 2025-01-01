---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_papyrus_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_papyrus_ordinary.init()

    return {
        description = "Ordinary papyrus as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary", "plant_papyrus_ordinary"},
        at_least_one = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_rainforest",
            "biome_ethereal_swamp",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_papyrus_ordinary.exec()

    unilib.register_decoration_generic("ethereal_plant_papyrus_ordinary", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_papyrus_ordinary",

        fill_ratio = 0.1,
        height_max = 4,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_plant_papyrus_ordinary.post()

    unilib.register_decoration_complete("ethereal_plant_papyrus_ordinary", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {
            "ethereal_forest_deciduous",
            "ethereal_rainforest",
            "ethereal_swamp",
        },
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 1,
        y_min = 1,
    })

end

