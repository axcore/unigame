---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_xocean_coral_block_bubble = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_xocean_coral_block_bubble.init()

    return {
        description = "Bubble coral block as decoration",
        depends = {"coral_block_bubble", "liquid_water_ordinary", "sand_ordinary"},
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

function unilib.pkg.deco_xocean_coral_block_bubble.exec()

    unilib.register_decoration("xocean_coral_block_bubble_1", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_coral_block_bubble_1.mts",

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

    unilib.register_decoration("xocean_coral_block_bubble_2", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_coral_block_bubble_2.mts",

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

end

function unilib.pkg.deco_xocean_coral_block_bubble.post()

    unilib.register_decoration_now("xocean_coral_block_bubble_1", nil, {
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

    unilib.register_decoration_now("xocean_coral_block_bubble_2", nil, {
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
