---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_stone_desert_with_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_stone_desert_with_iron.init()

    return {
        description = "Desert stone with iron as ore",
        depends = {"stone_desert", "stone_desert_with_iron"},
    }

end

function unilib.pkg.ore_ethereal_stone_desert_with_iron.post()

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        -- N.B. "default:stone_with_iron" in original code
        ore                     = "unilib:stone_desert_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -16,
        y_min                   = -63,
    })

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        -- N.B. "default:stone_with_iron" in original code
        ore                     = "unilib:stone_desert_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 27,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 6,
        y_max                   = -64,
        y_min                   = unilib.constant.y_min,
    })

end
