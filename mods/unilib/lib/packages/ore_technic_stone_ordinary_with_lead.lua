---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_technic_stone_ordinary_with_lead = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_technic_stone_ordinary_with_lead.init()

    return {
        description = "Ordinary stone with lead as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_lead"},
    }

end

function unilib.pkg.ore_technic_stone_ordinary_with_lead.post()

    unilib.register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = 423,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.3,
        y_max                   = 16,
        y_min                   = -16,
    })

    unilib.register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = 423,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.3,
        y_max                   = -16,
        y_min                   = -128,
    })

    unilib.register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 6 * 6 * 6,
        clust_size              = 3,
        flags                   = "absheight",
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = 423,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.3,
        y_max                   = -128,
        y_min                   = unilib.y_min,
    })

end
