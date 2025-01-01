---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_cabbage = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_cabbage.init()

    return {
        description = "Cabbage tree as decoration",
        depends = "tree_cabbage",
        at_least_one = {
            {
                "biome_aotearoa_coastal",
                "biome_aotearoa_dunes",
                "biome_aotearoa_lowland",
                "biome_aotearoa_scrubland",
                "biome_aotearoa_wetland",
            },
            {
                "dirt_antipodean",
                "dirt_custom_antipodean",
                "dirt_ordinary",
                "dirt_peat_forest",
                "gravel_ordinary",
                "sand_ironsand",
                "sand_ordinary",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_cabbage.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_cabbage_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_cabbage"
            biomes = {
                "aotearoa_coastal_pohutukawa_forest",
                "aotearoa_coastal_scrub",
                "aotearoa_dunes_ironsand",
                "aotearoa_dunes_pohutukawa",
                "aotearoa_dunes_sand",
                "aotearoa_scrubland_broadleaf",
                "aotearoa_scrubland_geothermal",
                "aotearoa_wetland_kahikatea_swamp",
            },
            place_on = {
                "unilib:dirt_antipodean_with_turf_coastal_scrub",
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_peat_forest",
                "unilib:sand_ironsand",
                "unilib:sand_ordinary",
            },
            y_max = 80,
            y_min = 3,
        })
        unilib.register_decoration_complete("aotearoa_tree_cabbage_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_cabbage"
            biomes = {
                "aotearoa_coastal_tussock",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_southern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_turf_coastal_tussock",
                "unilib:dirt_ordinary_with_litter_dry",
            },
            y_max = 80,
            y_min = 3,
        })

    end
    unilib.register_decoration_complete("aotearoa_tree_cabbage_crown", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "tree_cabbage"
        biomes = {
            "aotearoa_coastal_pohutukawa_forest",
            "aotearoa_coastal_scrub",
            "aotearoa_dunes_gravel",
            "aotearoa_dunes_ironsand",
            "aotearoa_dunes_pohutukawa",
            "aotearoa_dunes_sand",
            "aotearoa_lowland_hinau_forest",
            "aotearoa_lowland_kauri_forest",
            "aotearoa_lowland_maire_forest",
            "aotearoa_lowland_northern_podocarp_forest",
            "aotearoa_lowland_southern_podocarp_forest",
            "aotearoa_lowland_tawa_forest",
            "aotearoa_scrubland_broadleaf",
            "aotearoa_scrubland_geothermal",
        },
        place_on = {
            "unilib:dirt_antipodean_dark_with_litter_wet",
            "unilib:dirt_ordinary_with_litter_dry",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:gravel_ordinary",
            "unilib:sand_ironsand",
            "unilib:sand_ordinary",
        },
        y_max = 80,
        y_min = 3,
    })

end
