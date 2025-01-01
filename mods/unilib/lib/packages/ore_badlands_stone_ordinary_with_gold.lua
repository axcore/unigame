---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_badlands_stone_ordinary_with_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_badlands_stone_ordinary_with_gold.init()

    return {
        description = "Ordinary stone with gold as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_gold"},
    }

end

function unilib.pkg.ore_badlands_stone_ordinary_with_gold.post()

    unilib.register_ore({
        -- From badlands/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        biomes                  = {"badlands_mountains", "badlands_plains"},
        clust_num_ores          = 8,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -64,
    })

end
