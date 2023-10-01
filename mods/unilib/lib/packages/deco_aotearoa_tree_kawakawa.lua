---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_kawakawa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_kawakawa.init()

    return {
        description = "Kawakawa tree as decoration",
        depends = "tree_kawakawa",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_lowland"},
            {"dirt_antipodean", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_kawakawa.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_kawakawa_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kawakawa"
            biomes = {
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
            },
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_now("aotearoa_tree_kawakawa_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kawakawa"
            biomes = {
                "aotearoa_coastal_pohutukawa_forest",
                "aotearoa_lowland_northern_podocarp_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_rainforest",
            },
            y_max = 80,
            y_min = 5,
        })

    end

end
