---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_coral_xocean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_coral_xocean.init()

    return {
        description = "\"xocean\" coral for the \"gaia\" remix",
        notes = "Based on various xocean decoration packages, combined here into one package" ..
                " with \"gaia\" biomes",
        depends = "biome_gaia",
        optional = {
            "coral_block_bubble",
            "coral_block_fire",
            "coral_block_horn",
            "coral_block_rose",
            "coral_block_tube",
            "coral_rooted_bubble",
            "coral_rooted_fire",
            "coral_rooted_horn",
            "coral_rooted_rose",
            "coral_rooted_tube",
            "liquid_water_ordinary",
        },
    }

end

function unilib.pkg.deco_gaia_coral_xocean.post()

    --[[
    local biome_list = {
        "gaia_hot_humid_ocean",
        "gaia_hot_semihumid_ocean",
        "gaia_hot_temperate_ocean",
    }
    ]]--
    local biome_list = {
        "gaia_warm_humid_ocean",
        "gaia_warm_semihumid_ocean",
    }

    -- Rare coral block
    for part_name, octaves in pairs({
        bubble = 20,
        fire = 20,
        horn = 20,
        rose = 20,
        tube = 20,
    }) do

        unilib.register_decoration_simple({
            -- From xocean/init.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. "_1.mts",

            biomes = biome_list,
            flags = "force_placement",
            noise_params = {
                octaves = octaves,
                offset = 0.0001,
                persist = 0.7,
                scale = 0.0001,
                seed = 87112,
                spread = {x = 100000, y = 100000, z = 100000},
            },
            -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation =
            --      "random"
--          param2 = 48,
--          param2_max = 96,
            place_offset_y = -1,
            place_on = "group:sand",
            rotation = "random",
            sidelen = 2,
            y_max = -6,
            y_min = -16,
        })

    end

    -- Common coral block
    for part_name, octaves in pairs({
        bubble = 28,
        fire = 12,
        horn = 28,
        rose = 28,
        tube = 28,
    }) do

        unilib.register_decoration_simple({
            -- From xocean/init.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. "_2.mts",

            biomes = biome_list,
            flags = "force_placement",
            noise_params = {
                octaves = octaves,
                offset = 0.0001,
                persist = 0.7,
                scale = 0.001,
                seed = 87112,
                spread = {x = 100000, y = 100000, z = 100000},
            },
            -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation =
            --      "random"
--          param2 = 48,
--          param2_max = 96,
            place_offset_y = -1,
            place_on = "group:sand",
            rotation = "random",
            sidelen = 2,
            y_max = -6,
            y_min = -16,
        })

    end

    -- Extremely rare coral block
    for part_name, octaves in pairs({
        rose = 25,
        tube = 20,
    }) do

        unilib.register_decoration_simple({
            -- From xocean/init.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. "_3.mts",

            biomes = biome_list,
            flags = "force_placement",
            noise_params = {
                octaves = octaves,
                offset = 0.0001,
                persist = 0.7,
                scale = 0.000001,
                seed = 87112,
                spread = {x = 100000, y = 100000, z = 100000},
            },
            -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation =
            --      "random"
--          param2 = 48,
--          param2_max = 96,
            place_offset_y = -1,
            place_on = "group:sand",
            rotation = "random",
            sidelen = 1,
            y_max = -6,
            y_min = -16,
        })

    end

    -- Rooted coral and rooted coral skeleton
    for _, part_name in pairs({"", "_skeleton"}) do

        unilib.register_decoration_simple({
            -- From xocean/init.lua
            deco_type = "simple",
            decoration = {
                "unilib:coral_rooted_bubble" .. part_name,
                "unilib:coral_rooted_fire" .. part_name,
                "unilib:coral_rooted_horn" .. part_name,
                "unilib:coral_rooted_rose" .. part_name,
                "unilib:coral_rooted_tube" .. part_name,
            },

            biomes = biome_list,
            flags = "force_placement",
            noise_params = {
                octaves = 3,
                offset = -0.04,
                persist = 0.7,
                scale = 1.0,
                seed = 87112,
                spread = {x = 20, y = 20, z = 20},
            },
            -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation =
            --      "random"
--          param2 = 48,
--          param2_max = 96,
            place_offset_y = -1,
            -- N.B. In original code and in the corresponding unilib packages, rooted coral skeleton
            --      is only placed on non-skeleton block coral
            place_on = {
                "unilib:coral_block_bubble" .. part_name,
                "unilib:coral_block_fire" .. part_name,
                "unilib:coral_block_horn" .. part_name,
                "unilib:coral_block_rose" .. part_name,
                "unilib:coral_block_tube" .. part_name,
            },
            rotation = "random",
            sidelen = 16,
            y_max = -5,
            y_min = -50,
        })

    end

end
