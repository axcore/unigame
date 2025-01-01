---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_technic_stone_marble_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_technic_stone_marble_brown.init()

    return {
        description = "Brown marble as ore",
        depends = {"stone_marble_brown", "stone_ordinary"},
    }

end

function unilib.pkg.ore_technic_stone_marble_brown.post()

    unilib.register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_marble_brown",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 1,
        clust_scarcity          = 1,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.70,
            scale = 15,
            seed = 23,
            spread = {x = 150, y = 150, z = 150},
        },
        noise_threshold         = 0.4,
        y_max                   = -50,
        y_min                   = unilib.constant.y_min,
    })

end
