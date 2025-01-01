---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_sandstone_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_sandstone_desert.init()

    return {
        description = "Desert sandstone as ore",
        depends = {"biome_default_desert", "stone_desert", "stone_sandstone_desert"},
    }

end

function unilib.pkg.ore_default_stone_sandstone_desert.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "stratum",
        ore                     = "unilib:stone_sandstone_desert",
        wherein                 = "unilib:stone_desert",

        biomes                  = {"default_desert"},
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
        ore                     = "unilib:stone_sandstone_desert",
        wherein                 = "unilib:stone_desert",

        biomes                  = {"default_desert"},
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
