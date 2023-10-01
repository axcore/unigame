---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_common_daisy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_common_daisy.init()

    return {
        description = "Common tree daisy as decoration",
        depends = "tree_common_daisy",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_highland"},
            {"dirt_antipodean", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_common_daisy.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_common_daisy_clump_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_common_daisy"
            biomes = "aotearoa_coastal_muttonbird_scrub",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = 14,
            y_min = 3,
        })
        unilib.register_decoration_now("aotearoa_tree_common_daisy_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_common_daisy"
            biomes = "aotearoa_highland_pahautea_forest",
            place_on = "unilib:dirt_antipodean_with_moss",
            y_max = 120,
            y_min = 78,
        })

    end

end
