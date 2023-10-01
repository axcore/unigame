---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_wheki = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_wheki.init()

    return {
        description = "Wheki tree as decoration",
        depends = "tree_wheki",
        at_least_one = {
            {"biome_aotearoa_lowland", "biome_aotearoa_scrubland"},
            {"dirt_antipodean", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_wheki.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_wheki_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_wheki"
            biomes = {
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_fiordland_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kamahi_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_southern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
                "aotearoa_scrubland_broadleaf",
                "aotearoa_scrubland_geothermal",
                "aotearoa_scrubland_manuka",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
                "unilib:dirt_antipodean_with_moss",
                "unilib:dirt_ordinary_with_litter_rainforest",
            },
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_now("aotearoa_tree_wheki_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_wheki"
            biomes = "aotearoa_scrubland_broadleaf",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 80,
            y_min = 12,
        })

    end
    unilib.register_decoration_now("aotearoa_tree_wheki_crown", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "tree_wheki"
        biomes = {
            "aotearoa_lowland_beech_forest",
            "aotearoa_lowland_fiordland_forest",
            "aotearoa_lowland_hinau_forest",
            "aotearoa_lowland_kamahi_forest",
            "aotearoa_lowland_kauri_forest",
            "aotearoa_lowland_maire_forest",
            "aotearoa_lowland_northern_podocarp_forest",
            "aotearoa_lowland_southern_podocarp_forest",
            "aotearoa_lowland_tawa_forest",
            "aotearoa_scrubland_broadleaf",
            "aotearoa_scrubland_geothermal",
            "aotearoa_scrubland_manuka",
        },
        place_on = {
            "unilib:dirt_antipodean_dark_with_litter_beech",
            "unilib:dirt_antipodean_dark_with_litter_wet",
            "unilib:dirt_ordinary_with_litter_dry",
            "unilib:dirt_antipodean_with_moss",
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        y_max = 80,
        y_min = 12,
    })

end
