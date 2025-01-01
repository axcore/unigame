---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_badlands_clay_baked = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_badlands_clay_baked.init()

    return {
        description = "Baked clay as ore",
        notes = "First creates deposites of orange baked clay; then creates strata of baked" ..
                " clays in other colours, to create a layering effect",
        depends = {"biome_badlands", "clay_baked_basic"},
        at_least_one = {
            "dirt_ordinary",
            "gravel_ordinary",
            "sand_silver",
            "stone_ordinary",
            "stone_ordinary_with_coal",
            "stone_sandstone_silver",
        },
    }

end

function unilib.pkg.ore_badlands_clay_baked.post()

    unilib.register_ore({
        -- From badlands/init.lua
        ore_type                = "stratum",
        ore                     = "unilib:clay_baked_orange",
        wherein                 = {
            "unilib:dirt_ordinary",
            "unilib:gravel_ordinary",
            "unilib:sand_silver",
            "unilib:stone_ordinary",
            "unilib:stone_ordinary_with_coal",
            "unilib:stone_sandstone_silver",
        },

        biomes                  = {"badlands_mountains", "badlands_plains"},
        clust_scarcity          = 1,
        fill_ratio              = 10,
        y_max                   = unilib.constant.y_max,
        y_min                   = -10,
    })

    for i = 0, 4 do

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_natural",
            wherein             = "unilib:clay_baked_orange",

            biomes              = {"badlands_mountains", "badlands_plains"},
            clust_scarcity      = 1,
            noise_params        = {
                offset = 28 + (i * 50),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = 90122,
                octaves = 1,
            },
            stratum_thickness   = 2,
            y_max               = 31000,
            y_min               = -10,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_red",
            wherein             = "unilib:clay_baked_orange",

            biomes              = {"badlands_mountains", "badlands_plains"},
            clust_scarcity      = 1,
            noise_params        = {
                offset = 23 + (i * 8),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = 90122,
                octaves = 1,
            },
            stratum_thickness   = 2,
            y_max               = 31000,
            y_min               = -10,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_yellow",
            wherein             = "unilib:clay_baked_orange",

            biomes              = {"badlands_mountains", "badlands_plains"},
            clust_scarcity      = 1,
            noise_params        = {
                offset = 19 + (i * 16),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = 90122,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = 31000,
            y_min               = -10,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_brown",
            wherein             = "unilib:clay_baked_orange",

            biomes              = {"badlands_mountains", "badlands_plains"},
            clust_scarcity      = 1,
            noise_params        = {
                offset = 17 + (i * 5),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = 90122,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = 31000,
            y_min               = -10,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_grey_dark",
            wherein             = "unilib:clay_baked_orange",

            biomes              = {"badlands_mountains", "badlands_plains"},
            clust_scarcity      = 1,
            noise_params        = {
                offset = 16 + (i * 12),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = 90122,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = 31000,
            y_min               = -10,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_grey",
            wherein             = "unilib:clay_baked_orange",

            biomes              = {"badlands_mountains", "badlands_plains"},
            clust_scarcity      = 1,
            noise_params        = {
                offset = 14 + (i * 30),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = 90122,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = 31000,
            y_min               = -10,
        })

    end

end
