---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_beech_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_beech_black.init()

    return {
        description = "Black beech as decoration",
        depends = {"biome_aotearoa_lowland", "dirt_antipodean", "tree_beech_black"},
    }

end

function unilib.pkg.deco_aotearoa_tree_beech_black.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_beech_black_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_beech_black"
            biomes = "aotearoa_lowland_beech_forest",
            place_on = "unilib:dirt_antipodean_dark_with_litter_beech",
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_now("aotearoa_tree_beech_black_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_beech_black"
            biomes = {"aotearoa_lowland_hinau_forest", "aotearoa_lowland_maire_forest"},
            place_on = "unilib:dirt_ordinary_with_litter_dry",
            y_max = 80,
            y_min = 12,
        })

    end

end
