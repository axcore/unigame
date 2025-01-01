---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_beech_mountain = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_beech_mountain.init()

    return {
        description = "Mountain beech tree as decoration",
        depends = {"dirt_antipodean", "tree_beech_mountain"},
        at_least_one = {"biome_aotearoa_highland", "biome_aotearoa_lowland"},
    }

end

function unilib.pkg.deco_aotearoa_tree_beech_mountain.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_beech_mountain_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_beech_mountain"
            biomes = "aotearoa_highland_mountain_beech_forest",
            place_on = "unilib:dirt_antipodean_with_moss",
            y_max = 120,
            y_min = 78,
        })
        unilib.register_decoration_complete("aotearoa_tree_beech_mountain_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_beech_mountain"
            biomes = "aotearoa_lowland_kamahi_forest",
            place_on = "unilib:dirt_antipodean_with_moss",
            y_max = 80,
            y_min = 12,
        })

    end

end
