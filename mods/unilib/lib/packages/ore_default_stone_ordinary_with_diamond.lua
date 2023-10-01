---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_ordinary_with_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_ordinary_with_diamond.init()

    return {
        description = "Ordinary stone with diamond as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_diamond"},
    }

end

function unilib.pkg.ore_default_stone_ordinary_with_diamond.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 3,
        y_max                   = unilib.y_max,
        y_min                   = 1025,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 17 * 17 * 17,
        clust_size              = 3,
        y_max                   = -1024,
        y_min                   = -2047,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 3,
        y_max                   = -2048,
        y_min                   = unilib.y_min,
    })

end
