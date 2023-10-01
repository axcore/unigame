---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_technic_stone_granite_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_technic_stone_granite_dark.init()

    return {
        description = "Dark granite as ore",
        depends = {"stone_granite_dark", "stone_ordinary"},
    }

end

function unilib.pkg.ore_technic_stone_granite_dark.post()

    unilib.register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_granite_dark",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 1,
        clust_scarcity          = 1,
        clust_size              = 4,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.70,
            scale = 15,
            seed = 24,
            spread = {x = 130, y = 130, z = 130},
        },
        noise_threshold         = 0.4,
        y_max                   = -150,
        y_min                   = unilib.y_min,
    })

end
