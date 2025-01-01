---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_stone_desert_with_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_stone_desert_with_gold.init()

    return {
        description = "Desert stone with gold as ore",
        depends = {"stone_desert", "stone_desert_with_gold"},
    }

end

function unilib.pkg.ore_ethereal_stone_desert_with_gold.post()

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        -- N.B. "default:stone_with_gold" in original code
        ore                     = "unilib:stone_desert_with_gold",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 2,
        y_max                   = -64,
        y_min                   = -255,
    })

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        -- N.B. "default:stone_with_gold" in original code
        ore                     = "unilib:stone_desert_with_gold",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

end
