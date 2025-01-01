---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_beech_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_beech_silver.init()

    return {
        description = "Silver beech as decoration",
        depends = {"dirt_antipodean", "tree_beech_silver"},
        at_least_one = {"biome_aotearoa_highland", "biome_aotearoa_lowland"},
    }

end

function unilib.pkg.deco_aotearoa_tree_beech_silver.post()

    for i = 1, 2 do

        if unilib.global.pkg_executed_table["biome_aotearoa_lowland"] ~= nil then

            unilib.register_decoration_complete("aotearoa_tree_beech_silver_dense_" .. i, nil, {
                -- From aotearoa/spawn_trees.lua
                -- Completes decoration in package "tree_beech_silver"
                biomes = "aotearoa_lowland_fiordland_forest",
                place_on = "unilib:dirt_antipodean_dark_with_litter_beech",
                y_max = 80,
                y_min = 12,
            })

        end
        unilib.register_decoration_complete("aotearoa_tree_beech_silver_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_beech_silver"
            biomes = {
                "aotearoa_highland_mountain_beech_forest",
                "aotearoa_lowland_kamahi_forest",
            },
            place_on = "unilib:dirt_antipodean_with_moss",
            y_max = 120,
            y_min = 12,
        })

    end

end
