---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_mineral_mese_block = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_mineral_mese_block.init()

    return {
        description = "Mese block as ore",
        depends = {"mineral_mese", "stone_ordinary"},
    }

end

function unilib.pkg.ore_default_mineral_mese_block.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 36 * 36 * 36,
        clust_size              = 2,
        y_max                   = unilib.y_max,
        y_min                   = 1025,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 36 * 36 * 36,
        clust_size              = 2,
        y_max                   = -2048,
        y_min                   = -4095,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 28 * 28 * 28,
        clust_size              = 3,
        y_max                   = -4096,
        y_min                   = unilib.y_min,
    })

end
