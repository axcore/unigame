---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_gaia_hot_arid = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_gaia_hot_arid.init()

    return {
        description = "Baked clay as ore (for the \"gaia\" hot arid biome)",
        notes = "Based on the \"ore_badlands_clay_baked\" package, which in turn was based on" ..
                " code in the \"badlands\" mod",
        depends = {"biome_gaia", "clay_baked_basic", "misc_matrix_gaia"},
    }

end

function unilib.pkg.ore_gaia_hot_arid.post()

    local biome_list = {
--      "gaia_hot_arid_ocean",
--      "gaia_hot_arid_beach",
--      "gaia_hot_arid_coastal",
        "gaia_hot_arid_lowland",
        "gaia_hot_arid_shelf",
        "gaia_hot_arid_highland",
--      "gaia_hot_arid_mountain",
--      "gaia_hot_arid_strato",
    }

    -- N.B. In the "badlands" mod, strata begin at y=30, but in the "gaia" remix, they begin in the
    --      lowlands biome from y=40
    local gaia_offset = 10
    -- N.B. In the "badlands" mod, ore are placed between y=31000 and y=-10, but in the "gaia"
    --      remix, they only occur in three out of the eight height levels
    local y_max = 160       -- HIGHLAND
    local y_min = 40        -- COASTAL
    -- N.B. We will also use our own seed, so that our worlds aren't exactly the same as badlands
    --      worlds
--  local orig_seed = 90122
    local gaia_seed = 90123

    unilib.register_ore({
        -- From badlands/init.lua
        ore_type                = "stratum",
        ore                     = "unilib:clay_baked_orange",
        wherein                 = "unilib:misc_matrix_gaia_hot",

        biomes                  = biome_list,
        clust_scarcity          = 1,
        fill_ratio              = 10,
        y_max                   = y_max,
        y_min                   = y_min,
    })

    for i = 0, 4 do

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_natural",
            wherein             = "unilib:clay_baked_orange",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 28 + (i * 50),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 2,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_red",
            wherein             = "unilib:clay_baked_orange",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 23 + (i * 8),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 2,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_yellow",
            wherein             = "unilib:clay_baked_orange",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 19 + (i * 16),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_brown",
            wherein             = "unilib:clay_baked_orange",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 17 + (i * 5),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_grey_dark",
            wherein             = "unilib:clay_baked_orange",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 16 + (i * 12),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:clay_baked_grey",
            wherein             = "unilib:clay_baked_orange",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 14 + (i * 30),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 1,
            y_max               = y_max,
            y_min               = y_min,
        })

    end

end
