---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_stone_desert_with_aetherium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_stone_desert_with_aetherium.init()

    return {
        description = "Desert stone with aetherium as ore",
        depends = {"stone_desert", "stone_desert_with_aetherium"},
    }

end

function unilib.pkg.ore_ethereal_stone_desert_with_aetherium.post()

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_desert_with_aetherium",
        wherein                 = "unilib:stone_desert",

        biomes                  = "ethereal_caves",
        clust_num_ores          = 1,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 1,
        y_max                   = 40,
        y_min                   = 5,
    })

end
