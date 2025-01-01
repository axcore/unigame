---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.feature_aotearoa_liquid_mud_boiling = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.feature_aotearoa_liquid_mud_boiling.init()

    return {
        description = "Boiling mud pool feature",
        depends = {"liquid_mud_boiling", "sand_silt_antipodean"},
        at_least_one = {
            {"biome_aotearoa_dunes", "biome_aotearoa_scrubland"},
            {"dirt_ordinary", "sand_volcanic"},
        },
    }

end

function unilib.pkg.feature_aotearoa_liquid_mud_boiling.exec()

    unilib.register_decoration_generic("aotearoa_liquid_mud_boiling_pool_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_feature_liquid_mud_boiling_pool_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.8,
            scale = 0.005,
            seed = 128774,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration_generic("aotearoa_liquid_mud_boiling_pool_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_feature_liquid_mud_boiling_pool_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.8,
            scale = 0.005,
            seed = 186674,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })

end

function unilib.pkg.feature_aotearoa_liquid_mud_boiling.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("aotearoa_liquid_mud_boiling_pool_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            biomes = {
                "aotearoa_scrubland_geothermal",
                "aotearoa_dunes_white_island",
            },
            place_on = {
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:sand_volcanic",
            },
            y_max = 27,
            y_min = 2,
        })

    end

end
