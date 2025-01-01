---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_rimu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_rimu.init()

    return {
        description = "Rimu tree as decoration",
        depends = {"biome_aotearoa_lowland", "dirt_antipodean", "tree_rimu"},
    }

end

function unilib.pkg.deco_aotearoa_tree_rimu.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_rimu_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_rimu"
            biomes = {
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_fiordland_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kamahi_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
                "unilib:dirt_antipodean_with_moss",
            },
            y_max = 80,
            y_min = 12,
        })
        unilib.register_decoration_complete("aotearoa_tree_rimu_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_rimu"
            biomes = "aotearoa_lowland_southern_podocarp_forest",
            place_on = "unilib:dirt_antipodean_dark_with_litter_wet",
            y_max = 80,
            y_min = 12,
        })

    end

end
