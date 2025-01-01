---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_stone_ordinary_with_aetherium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_stone_ordinary_with_aetherium.init()

    return {
        description = "Ordinary stone with aetherium as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_aetherium"},
    }

end

function unilib.pkg.ore_ethereal_stone_ordinary_with_aetherium.post()

    -- Aetherium in floatlands
    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_aetherium",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 6,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 2,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

end
