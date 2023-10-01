---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_moss_antipodean_thick = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_moss_antipodean_thick.init()

    return {
        description = "Thick Antipodean moss",
        depends = "moss_antipodean_thick",
        at_least_one = {
            {
                "biome_aotearoa_alpine",
                "biome_aotearoa_coastal",
                "biome_aotearoa_highland",
                "biome_aotearoa_lowland",
                "biome_aotearoa_ocean",
                "biome_aotearoa_scrubland",
                "biome_aotearoa_shore",
                "biome_aotearoa_wetland",
            },
            {
                "clay_gumland",
                "dirt_antipodean",
                "dirt_ordinary",
                "dirt_peat_forest",
                "dirt_peat_restiad",
                "stone_andesite_antipodean",
                "stone_schist_antipodean",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_moss_antipodean_thick.post()

    unilib.register_decoration_now("aotearoa_moss_antipodean_thick_dense", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "moss_antipodean_thick"
        biomes = {
            "aotearoa_coastal_muttonbird_scrub",
            "aotearoa_highland_mountain_beech_forest",
            "aotearoa_highland_pahautea_forest",
            "aotearoa_highland_peat_bog",
            "aotearoa_lowland_fiordland_forest",
            "aotearoa_lowland_kamahi_forest",
            "aotearoa_ocean_subantarctic",
            "aotearoa_shore_subantarctic",
            "aotearoa_wetland_kahikatea_swamp",
            "aotearoa_wetland_peat_bog",
        },
        place_on = {
            "unilib:dirt_antipodean_dark_with_litter_beech",
            "unilib:dirt_antipodean_with_moss",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_peat_forest",
            "unilib:dirt_peat_restiad",
            "unilib:stone_andesite_antipodean",
        },
        y_max = 120,
        y_min = 3,
    })
    unilib.register_decoration_now("aotearoa_moss_antipodean_thick_rare", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "moss_antipodean_thick"
        biomes = {
            "aotearoa_alpine_fellfield",
            "aotearoa_highland_mountain_tussock",
            "aotearoa_lowland_beech_forest",
            "aotearoa_lowland_hinau_forest",
            "aotearoa_lowland_kauri_forest",
            "aotearoa_lowland_maire_forest",
            "aotearoa_lowland_northern_podocarp_forest",
            "aotearoa_lowland_southern_podocarp_forest",
            "aotearoa_lowland_tawa_forest",
            "aotearoa_scrubland_broadleaf",
            "aotearoa_scrubland_geothermal",
            "aotearoa_wetland_fen",
            "aotearoa_wetland_gumland",
        },
        place_on = {
            "unilib:clay_gumland_topsoil",
            "unilib:dirt_antipodean_dark_with_litter_beech",
            "unilib:dirt_antipodean_dark_with_litter_wet",
            "unilib:dirt_ordinary_with_litter_dry",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_peat_restiad",
            "unilib:stone_schist_antipodean",
        },
        y_max = 140,
        y_min = 12,
    })

end
