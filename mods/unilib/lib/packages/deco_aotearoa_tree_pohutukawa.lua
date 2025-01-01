---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_pohutukawa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_pohutukawa.init()

    return {
        description = "Pohutukawa tree as decoration",
        depends = "tree_pohutukawa",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_dunes"},
            {"dirt_ordinary", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_pohutukawa.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_pohutukawa_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_pohutukawa"
            biomes = "aotearoa_dunes_pohutukawa",
            place_on = "unilib:sand_ordinary",
            y_max = 5,
            y_min = 3,
        })
        unilib.register_decoration_complete("aotearoa_tree_pohutukawa_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_pohutukawa"
            biomes = "aotearoa_coastal_pohutukawa_forest",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 14,
            y_min = 3,
        })

    end

end
