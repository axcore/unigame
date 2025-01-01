---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_sand_undersea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_sand_undersea.init()

    return {
        description = "Undersea sand as ore",
        depends = {"sand_ordinary", "sand_undersea"},
    }

end

function unilib.pkg.ore_ethereal_sand_undersea.post()

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:sand_undersea",
        wherein                 = "unilib:sand_ordinary",

        clust_num_ores          = 24,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -100,
    })

end
