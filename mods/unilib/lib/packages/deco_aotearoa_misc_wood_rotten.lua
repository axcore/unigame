---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_misc_wood_rotten = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_misc_wood_rotten.init()

    return {
        description = "Rotten wood as decoration",
        depends = "misc_wood_rotten",
        clay_gumland = {
            {
                "biome_aotearoa_highland",
                "biome_aotearoa_lowland",
                "biome_aotearoa_scrubland",
                "biome_aotearoa_wetland",
            },
            {
                "clay_gumland",
                "dirt_antipodean",
                "dirt_ordinary",
                "dirt_peat_forest",
                "dirt_peat_restiad",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_misc_wood_rotten.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_misc_wood_rotten_stump_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "misc_wood_rotten"
            biomes = {
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_fiordland_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_southern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
                "aotearoa_wetland_fen",
                "aotearoa_wetland_gumland",
                "aotearoa_wetland_kahikatea_swamp",
            },
            place_on = {
                "unilib:clay_gumland_topsoil",
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
                "unilib:dirt_peat_forest",
                "unilib:dirt_peat_restiad",
            },
            y_max = 80,
            y_min = 5,
        })
        unilib.register_decoration_complete("aotearoa_misc_wood_rotten_stump_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "misc_wood_rotten"
            biomes = {
                "aotearoa_highland_mountain_beech_forest",
                "aotearoa_highland_pahautea_forest",
                "aotearoa_lowland_kamahi_forest",
                "aotearoa_scrubland_broadleaf",
                "aotearoa_scrubland_geothermal",
                "aotearoa_scrubland_manuka",
            },
            place_on = {
                "unilib:dirt_antipodean_with_moss",
                "unilib:dirt_ordinary_with_litter_rainforest",
            },
            y_max = 120,
            y_min = 12,
        })

    end
    unilib.register_decoration_complete("aotearoa_misc_wood_rotten_stump", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "misc_wood_rotten"
        biomes = {
            "aotearoa_highland_mountain_beech_forest",
            "aotearoa_highland_pahautea_forest",
            "aotearoa_lowland_beech_forest",
            "aotearoa_lowland_fiordland_forest",
            "aotearoa_lowland_hinau_forest",
            "aotearoa_lowland_kamahi_forest",
            "aotearoa_lowland_kauri_forest",
            "aotearoa_lowland_maire_forest",
            "aotearoa_lowland_northern_podocarp_forest",
            "aotearoa_lowland_tawa_forest",
            "aotearoa_scrubland_broadleaf",
            "aotearoa_scrubland_geothermal",
            "aotearoa_scrubland_manuka",
            "aotearoa_wetland_fen",
            "aotearoa_wetland_gumland",
            "aotearoa_wetland_kahikatea_swamp",
        },
        place_on = {
            "unilib:clay_gumland_topsoil",
            "unilib:dirt_antipodean_with_moss",
            "unilib:dirt_antipodean_dark_with_litter_beech",
            "unilib:dirt_antipodean_dark_with_litter_wet",
            "unilib:dirt_ordinary_with_litter_dry",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_peat_forest",
            "unilib:dirt_peat_restiad",
        },
        y_max = 120,
        y_min = 5,
    })

end
