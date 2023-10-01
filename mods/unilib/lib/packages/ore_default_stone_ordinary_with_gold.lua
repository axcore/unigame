---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_ordinary_with_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_ordinary_with_gold.init()

    return {
        description = "Ordinary stone with gold as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_gold"},
    }

end

function unilib.pkg.ore_default_stone_ordinary_with_gold.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = unilib.y_max,
        y_min                   = 1025,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 3,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 2,
        y_max                   = -256,
        y_min                   = -511,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = -512,
        y_min                   = unilib.y_min,
    })

end
