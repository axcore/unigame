---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_palm_nikau = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_palm_nikau.init()

    return {
        description = "Nikau palm tree as decoration",
        depends = "tree_palm_nikau",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_lowland"},
            {"dirt_antipodean", "dirt_custom_antipodean", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_palm_nikau.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_palm_nikau_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_palm_nikau"
            biomes = {
                "aotearoa_coastal_pohutukawa_forest",
                "aotearoa_coastal_scrub",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_antipodean_with_turf_coastal_scrub",
                "unilib:dirt_ordinary_with_litter_dry",
                "unilib:dirt_ordinary_with_litter_rainforest",
            },
            y_max = 80,
            y_min = 5,
        })
        unilib.register_decoration_complete("aotearoa_tree_palm_nikau_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_palm_nikau"
            biomes = {
                "aotearoa_coastal_tussock",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_southern_podocarp_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_turf_coastal_tussock",
                "unilib:dirt_ordinary_with_litter_dry",
            },
            y_max = 80,
            y_min = 5,
        })

    end
    unilib.register_decoration_complete("aotearoa_tree_palm_nikau_crown", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "tree_palm_nikau"
        biomes = {
            "aotearoa_coastal_pohutukawa_forest",
            "aotearoa_coastal_scrub",
            "aotearoa_lowland_hinau_forest",
            "aotearoa_lowland_kauri_forest",
            "aotearoa_lowland_maire_forest",
            "aotearoa_lowland_northern_podocarp_forest",
            "aotearoa_lowland_southern_podocarp_forest",
            "aotearoa_lowland_tawa_forest",
        },
        place_on = {
            "unilib:dirt_antipodean_dark_with_litter_wet",
            "unilib:dirt_antipodean_with_turf_coastal_scrub",
            "unilib:dirt_ordinary_with_litter_dry",
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        y_max = 80,
        y_min = 5,
    })

end
