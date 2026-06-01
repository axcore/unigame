---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_poppy_arctic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_poppy_arctic.init()

    return {
        description = "Arctic poppy as decoration",
        at_least_one = {
            {
                "biome_default_desert_cold",
                "biome_default_forest_coniferous",
                "biome_default_grassland_snowy",
                "biome_default_taiga",
                "biome_default_tundra",
                "biome_ethereal_desert_cold",
                "biome_ethereal_forest_coniferous",
                "biome_ethereal_frost",
                "biome_ethereal_grassland_snowy",
                "biome_ethereal_taiga",
                "biome_ethereal_tundra",
            },
            {
                "dirt_ordinary_with_cover_snow",
                "dirt_ordinary_with_litter_coniferous",
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_cold",
                "dirt_permafrost_ordinary",
                "snow_ordinary",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_poppy_arctic.post()

    unilib.register_decoration_complete("elysflowers_flower_poppy_arctic", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_poppy_arctic"
        biomes = {
            "default_desert_cold",
            "default_forest_coniferous",
            "default_grassland_snowy",
            "default_taiga",
            "default_tundra",
            "ethereal_desert_cold",
            "ethereal_forest_coniferous",
            "ethereal_frost",
            "ethereal_grassland_snowy",
            "ethereal_taiga",
            "ethereal_tundra",
        },
        num_spawn_by = -1,
        place_on = {
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_cold",
            "unilib:dirt_permafrost_ordinary_with_litter_stone",
            "unilib:dirt_permafrost_ordinary_with_moss",
            "unilib:snow_ordinary_block",
        },
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
