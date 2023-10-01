---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_manuka = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_manuka.init()

    return {
        description = "Manuka tree as decoration",
        depends = "tree_manuka",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_scrubland", "biome_aotearoa_wetland"},
            {"clay_gumland", "dirt_ordinary", "dirt_peat_restiad"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_manuka.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_manuka_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_manuka"
            biomes = {
                "aotearoa_coastal_scrub",
                "aotearoa_coastal_tussock",
            },
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_ordinary_with_turf_dry",
            },
            y_max = 80,
            y_min = 3,
        })
        unilib.register_decoration_now("aotearoa_tree_manuka_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_manuka"
            biomes = {
                "aotearoa_scrubland_geothermal",
                "aotearoa_wetland_fen",
                "aotearoa_wetland_gumland",
            },
            place_on = {
                "unilib:clay_gumland_topsoil",
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_peat_restiad",
            },
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_now("aotearoa_tree_manuka_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_manuka"
            biomes = "aotearoa_scrubland_manuka",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 80,
            y_min = 12,
        })

    end
    unilib.register_decoration_now("aotearoa_tree_manuka_leaves", nil, {
        -- From aotearoa/spawn_plants.lua
        -- Completes decoration in package "tree_manuka"
        biomes = "aotearoa_wetland_gumland",
        place_on = "unilib:clay_gumland_topsoil",
        y_max = 80,
        y_min = 12,
    })

end
