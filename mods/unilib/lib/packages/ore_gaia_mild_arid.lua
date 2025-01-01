---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_gaia_mild_arid = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_gaia_mild_arid.init()

    return {
        description = "Baked clay as ore (for the \"gaia\" mild arid biome)",
        notes = "Based on the \"ore_badlands_clay_baked\" package, which in turn was based on" ..
                " code in the \"badlands\" mod",
        depends = {"biome_gaia", "misc_matrix_gaia", "stone_sandstone_golden"},
        optional = {
            "stone_sandstone_brown",
            "stone_sandstone_desert",
            "stone_sandstone_ordinary",
            "stone_sandstone_pink",
            "stone_sandstone_beige",
            "stone_sandstone_white",
        },
    }

end

function unilib.pkg.ore_gaia_mild_arid.post()

    local biome_list = {
--      "gaia_mild_arid_ocean",
--      "gaia_mild_arid_beach",
--      "gaia_mild_arid_coastal",
        "gaia_mild_arid_lowland",
        "gaia_mild_arid_shelf",
        "gaia_mild_arid_highland",
--      "gaia_mild_arid_mountain",
--      "gaia_mild_arid_strato",
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
    local gaia_seed = 90124

    unilib.register_ore({
        -- From badlands/init.lua
        ore_type                = "stratum",
        ore                     = "unilib:stone_sandstone_golden",
        wherein                 = "unilib:misc_matrix_gaia_mild",

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
            ore                 = "unilib:stone_sandstone_beige",
            wherein             = "unilib:stone_sandstone_golden",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 28 + (i * 50),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 3,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:stone_sandstone_desert",
            wherein             = "unilib:stone_sandstone_golden",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 23 + (i * 8),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 3,
            y_max               = y_max,
            y_min               = y_min,
        })

        unilib.register_ore({
            -- From badlands/init.lua
            ore_type            = "stratum",
            ore                 = "unilib:stone_sandstone_ordinary",
            wherein             = "unilib:stone_sandstone_golden",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 19 + (i * 16),
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
            ore                 = "unilib:stone_sandstone_white",
            wherein             = "unilib:stone_sandstone_golden",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 17 + (i * 5),
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
            ore                 = "unilib:stone_sandstone_pink",
            wherein             = "unilib:stone_sandstone_golden",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 16 + (i * 12),
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
            ore                 = "unilib:stone_sandstone_brown",
            wherein             = "unilib:stone_sandstone_golden",

            biomes              = biome_list,
            clust_scarcity      = 1,
            noise_params        = {
                offset = gaia_offset + 14 + (i * 30),
                scale = 16,
                spread = {x = 128, y = 128, z = 128},
                seed = gaia_seed,
                octaves = 1,
            },
            stratum_thickness   = 2,
            y_max               = y_max,
            y_min               = y_min,
        })

    end

end
