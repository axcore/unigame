---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_sandstone_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_sandstone_silver.init()

    return {
        description = "Silver sandstone as ore",
        depends = {"biome_default_desert_cold", "stone_ordinary", "stone_sandstone_silver"},
    }

end

function unilib.pkg.ore_default_stone_sandstone_silver.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "stratum",
        ore                     = "unilib:stone_sandstone_silver",
        wherein                 = "unilib:stone_ordinary",

        biomes                  = {"default_desert_cold"},
        clust_scarcity          = 1,
        noise_params            = {
            octaves = 1,
            offset = 28,
            scale = 16,
            seed = 90122,
            spread = {x = 128, y = 128, z = 128},
        },
        stratum_thickness       = 4,
        y_max                   = 46,
        y_min                   = 10,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "stratum",
        ore                     = "unilib:stone_sandstone_silver",
        wherein                 = "unilib:stone_ordinary",

        biomes                  = {"default_desert_cold"},
        clust_scarcity          = 1,
        noise_params            = {
            octaves = 1,
            offset = 24,
            scale = 16,
            seed = 90122,
            spread = {x = 128, y = 128, z = 128},
        },
        stratum_thickness       = 2,
        y_max                   = 42,
        y_min                   = 6,
    })

end
