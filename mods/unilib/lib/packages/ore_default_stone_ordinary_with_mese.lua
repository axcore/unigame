---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_ordinary_with_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_ordinary_with_mese.init()

    return {
        description = "Ordinary stone with mese crystals as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_mese"},
    }

end

function unilib.pkg.ore_default_stone_ordinary_with_mese.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 14 * 14 * 14,
        clust_size              = 3,
        y_max                   = unilib.y_max,
        y_min                   = 1025,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 18 * 18 * 18,
        clust_size              = 2,
        y_max                   = -512,
        y_min                   = -1023,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 14 * 14 * 14,
        clust_size              = 3,
        y_max                   = -1024,
        y_min                   = unilib.y_min,
    })

end
