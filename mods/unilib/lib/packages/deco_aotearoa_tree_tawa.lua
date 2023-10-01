---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_tawa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_tawa.init()

    return {
        description = "Tawa tree as decoration",
        depends = {"biome_aotearoa_lowland", "dirt_antipodean", "tree_tawa"},
    }

end

function unilib.pkg.deco_aotearoa_tree_tawa.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_tawa_normal_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_tawa"
            biomes = "aotearoa_lowland_kauri_forest",
            place_on = "unilib:dirt_ordinary_with_litter_dry",
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_now("aotearoa_tree_tawa_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_tawa"
            biomes = "aotearoa_lowland_tawa_forest",
            place_on = "unilib:dirt_antipodean_dark_with_litter_wet",
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_now("aotearoa_tree_tawa_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_tawa"
            biomes = "aotearoa_lowland_maire_forest",
            place_on = "unilib:dirt_ordinary_with_litter_dry",
            y_max = 80,
            y_min = 12,
        })

    end

end
