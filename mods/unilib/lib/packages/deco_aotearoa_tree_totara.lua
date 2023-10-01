---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_totara = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_totara.init()

    return {
        description = "Totara tree as decoration",
        depends = {"dirt_antipodean", "tree_totara"},
        at_least_one = {"biome_aotearoa_lowland", "biome_aotearoa_ocean"},
    }

end

function unilib.pkg.deco_aotearoa_tree_totara.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_totara_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_totara"
            biomes = {
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_southern_podocarp_forest",
                "aotearoa_lowland_tawa_forest",
                "aotearoa_ocean_fiordland",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
            },
            y_max = 80,
            y_min = 12,
        })
        if unilib.pkg_executed_table["biome_aotearoa_lowland"] ~= nil then

            unilib.register_decoration_now("aotearoa_tree_totara_dense_" .. i, nil, {
                -- From aotearoa/spawn_trees.lua
                -- Completes decoration in package "tree_totara"
                biomes = "aotearoa_lowland_northern_podocarp_forest",
                place_on = "unilib:dirt_antipodean_dark_with_litter_wet",
                y_max = 80,
                y_min = 12,
            })

        end

    end

end
