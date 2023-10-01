---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_kahikatea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_kahikatea.init()

    return {
        description = "Kahikatea tree as decoration",
        depends = "tree_kahikatea",
        at_least_one = {
            {"biome_aotearoa_lowland", "biome_aotearoa_wetland"},
            {"dirt_antipodean", "dirt_peat_forest"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_kahikatea.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_kahikatea_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kahikatea"
            biomes = "aotearoa_wetland_kahikatea_swamp",
            place_on = "unilib:dirt_peat_forest",
            y_max = 80,
            y_min = 5,
        })
        unilib.register_decoration_now("aotearoa_tree_kahikatea_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kahikatea"
            biomes = {
                "aotearoa_lowland_fiordland_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_southern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
            },
            y_max = 80,
            y_min = 12,
        })

    end

end
