---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_karo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_karo.init()

    return {
        description = "Karo tree as decoration",
        depends = "tree_karo",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_dunes"},
            {
                "dirt_ordinary",
                "gravel_ordinary",
                "sand_ironsand",
                "sand_ordinary",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_karo.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_karo_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_karo"
            biomes = {
                "aotearoa_coastal_pohutukawa_forest",
                "aotearoa_coastal_scrub",
                "aotearoa_dunes_gravel",
                "aotearoa_dunes_ironsand",
                "aotearoa_dunes_pohutukawa",
                "aotearoa_dunes_sand",
            },
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:gravel_ordinary",
                "unilib:sand_ironsand",
                "unilib:sand_ordinary",
            },
            y_max = 14,
            y_min = 3,
        })
        unilib.register_decoration_now("aotearoa_tree_karo_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_karo"
            biomes = "aotearoa_coastal_pohutukawa_forest",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 14,
            y_min = 3,
        })

    end

end
