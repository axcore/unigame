---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_sandstone_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_sandstone_ordinary.init()

    return {
        description = "Ordinary sandstone as ore",
        depends = {"biome_default_desert", "stone_desert", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.ore_default_stone_sandstone_ordinary.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "stratum",
        ore                     = "unilib:stone_sandstone_ordinary",
        wherein                 = "unilib:stone_desert",

        biomes                  = {"default_desert"},
        clust_scarcity          = 1,
        noise_params            = {
            octaves = 1,
            offset = 21,
            scale = 16,
            seed = 90122,
            spread = {x = 128, y = 128, z = 128},
        },
        stratum_thickness       = 2,
        y_max                   = 39,
        y_min                   = 3,
    })

end
