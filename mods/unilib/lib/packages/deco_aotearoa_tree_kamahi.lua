---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_kamahi = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_kamahi.init()

    return {
        description = "Kamahi tree as decoration",
        depends = "tree_kamahi",
        at_least_one = {
            {
                "biome_aotearoa_coastal",
                "biome_aotearoa_highland",
                "biome_aotearoa_lowland",
            },
            {"dirt_antipodean", "dirt_ordinary"},
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_kamahi.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_kamahi_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kamahi"
            biomes = {
                "aotearoa_highland_mountain_beech_forest",
                "aotearoa_highland_pahautea_forest",
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_fiordland_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_coastal_muttonbird_scrub",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_tawa_forest",
            },
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
                "unilib:dirt_antipodean_with_moss",
                "unilib:dirt_ordinary_with_litter_rainforest",
            },
            y_max = 118,
            y_min = 8,
        })
        unilib.register_decoration_now("aotearoa_tree_kamahi_dense_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kamahi"
            biomes = "aotearoa_lowland_kamahi_forest",
            place_on = "unilib:dirt_antipodean_with_moss",
            y_max = 80,
            y_min = 12,
        })

    end

end
