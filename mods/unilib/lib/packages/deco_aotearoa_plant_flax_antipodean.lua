---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_plant_flax_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_plant_flax_antipodean.init()

    return {
        description = "Antipodean flax plant as decoration",
        depends = "plant_flax_antipodean",
        at_least_one = {
            {
                "biome_aotearoa_coastal",
                "biome_aotearoa_dunes",
                "biome_aotearoa_scrubland",
                "biome_aotearoa_wetland",
            },
            {
                "dirt_custom_antipodean",
                "dirt_ordinary",
                "dirt_peat_forest",
                "dirt_peat_restiad",
                "gravel_ordinary",
                "sand_ironsand",
                "sand_ordinary",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_plant_flax_antipodean.post()

    unilib.register_decoration_complete("aotearoa_plant_flax_antipodean_normal", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_flax_antipodean"
        biomes = {
            "aotearoa_coastal_scrub",
            "aotearoa_coastal_pohutukawa_forest",
            "aotearoa_dunes_gravel",
            "aotearoa_dunes_pohutukawa",
            "aotearoa_dunes_ironsand",
            "aotearoa_dunes_sand",
            "aotearoa_scrubland_geothermal",
        },
        place_on = {
            "unilib:dirt_antipodean_with_turf_coastal_scrub",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:gravel_ordinary",
            "unilib:sand_ironsand",
            "unilib:sand_ordinary",
        },
        y_max = 80,
        y_min = 3,
    })
    unilib.register_decoration_complete("aotearoa_plant_flax_antipodean_dense", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "plant_flax_antipodean"
        biomes = {
            "aotearoa_coastal_tussock",
            "aotearoa_wetland_fen",
            "aotearoa_wetland_kahikatea_swamp",
        },
        place_on = {
            "unilib:dirt_ordinary_with_turf_coastal_tussock",
            "unilib:dirt_peat_forest",
            "unilib:dirt_peat_restiad",
        },
        y_max = 80,
        y_min = 3,
    })

end
