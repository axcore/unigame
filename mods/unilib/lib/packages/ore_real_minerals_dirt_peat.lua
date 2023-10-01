---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_real_minerals_dirt_peat = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_real_minerals_dirt_peat.init()

    return {
        description = "Peat as ore",
        depends = {"dirt_ordinary", "dirt_peat"},
    }

end

function unilib.pkg.ore_real_minerals_dirt_peat.post()

    unilib.register_ore({
        -- From real_minerals/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:dirt_peat",
        wherein                 = "unilib:dirt_ordinary",

        clust_num_ores          = 343,
        clust_scarcity          = 20 * 20 * 20,
        clust_size              = 7,
        y_max                   = 0,
        y_min                   = unilib.y_min,
    })

end

