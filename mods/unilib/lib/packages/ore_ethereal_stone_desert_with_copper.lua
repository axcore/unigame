---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_stone_desert_with_copper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_stone_desert_with_copper.init()

    return {
        description = "Desert stone with copper as ore",
        depends = {"stone_desert", "stone_desert_with_copper"},
    }

end

function unilib.pkg.ore_ethereal_stone_desert_with_copper.post()

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        -- N.B. "default:stone_with_copper" in original code
        ore                     = "unilib:stone_desert_with_copper",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -64,
        y_min                   = unilib.y_min,
    })

end
