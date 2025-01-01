---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_xocean_coral_block_tube = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_xocean_coral_block_tube.init()

    return {
        description = "Tube coral block as decoration",
        depends = {"coral_block_tube", "sand_ordinary", "shared_xocean"},
        at_least_one = {
            "biome_default_desert_cold",
            "biome_default_desert_sandstone",
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_grassland_snowy",
            "biome_default_taiga",
        },
    }

end

function unilib.pkg.deco_xocean_coral_block_tube.exec()

    --[[
    unilib.register_decoration_generic("xocean_coral_block_tube_1", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_tube_1.mts",

        flags = "force_placement",
        noise_params = {
            octaves = 20,
            offset = 0.0001,
            persist = 0.7,
            scale = 0.0001,
            seed = 87112,
            spread = {x = 100000, y = 100000, z = 100000},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 2,
    })

    unilib.register_decoration_generic("xocean_coral_block_tube_2", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_tube_2.mts",

        flags = "force_placement",
        noise_params = {
            octaves = 28,
            offset = 0.0001,
            persist = 0.7,
            scale = 0.001,
            seed = 87112,
            spread = {x = 100000, y = 100000, z = 100000},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 2,
    })

    unilib.register_decoration_generic("xocean_coral_block_tube_3", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_tube_3.mts",

        flags = "force_placement",
        noise_params = {
            octaves = 20,
            offset = 0.0001,
            persist = 0.7,
            scale = 0.000001,
            seed = 87112,
            spread = {x = 100000, y = 100000, z = 100000},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        sidelen = 1,
    })
    ]]--

    unilib.pkg.shared_xocean.create_generic_rare_block("tube", 20)
    unilib.pkg.shared_xocean.create_generic_common_block("tube", 28)
    unilib.pkg.shared_xocean.create_generic_very_rare_block("tube", 20)

end

function unilib.pkg.deco_xocean_coral_block_tube.post()

    --[[
    unilib.register_decoration_complete("xocean_coral_block_tube_1", nil, {
        -- From xocean/init.lua
        biomes = {
            "default_desert_cold_ocean",
            "default_desert_sandstone_ocean",
            "default_forest_coniferous_ocean",
            "default_forest_deciduous_ocean",
            "default_grassland_ocean",
            "default_grassland_snowy_ocean",
            "default_taiga_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = -6,
        y_min = -16,
    })

    unilib.register_decoration_complete("xocean_coral_block_tube_2", nil, {
        -- From xocean/init.lua
        biomes = {
            "default_desert_cold_ocean",
            "default_desert_sandstone_ocean",
            "default_forest_coniferous_ocean",
            "default_forest_deciduous_ocean",
            "default_grassland_ocean",
            "default_grassland_snowy_ocean",
            "default_taiga_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = -6,
        y_min = -16,
    })

    unilib.register_decoration_complete("xocean_coral_block_tube_3", nil, {
        -- From xocean/init.lua
        biomes = {
            "default_desert_cold_ocean",
            "default_desert_sandstone_ocean",
            "default_forest_coniferous_ocean",
            "default_forest_deciduous_ocean",
            "default_grassland_ocean",
            "default_grassland_snowy_ocean",
            "default_taiga_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = -6,
        y_min = -16,
    })
    ]]--

    for i = 1, 3 do

        unilib.register_decoration_complete("xocean_coral_block_tube_" .. i, nil, {
            -- From xocean/init.lua
            biomes = {
                "default_desert_cold_ocean",
                "default_desert_sandstone_ocean",
                "default_forest_coniferous_ocean",
                "default_forest_deciduous_ocean",
                "default_grassland_ocean",
                "default_grassland_snowy_ocean",
                "default_taiga_ocean",
            },
            place_on = "unilib:sand_ordinary",
            y_max = -6,
            y_min = -16,
        })

    end

end
