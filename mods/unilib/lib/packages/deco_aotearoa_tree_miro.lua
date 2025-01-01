---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_miro = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_miro.init()

    return {
        description = "Miro tree as decoration",
        depends = {"biome_aotearoa_lowland", "dirt_antipodean", "tree_miro"},
    }

end

function unilib.pkg.deco_aotearoa_tree_miro.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_tree_miro_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_miro"
            biomes = {
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kamahi_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_northern_podocarp_forest",
                "aotearoa_lowland_southern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_with_moss",
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
            },
            y_max = 80,
            y_min = 12,
        })

    end

end
