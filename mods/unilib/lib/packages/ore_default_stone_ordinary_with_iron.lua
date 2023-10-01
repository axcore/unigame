---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_stone_ordinary_with_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_stone_ordinary_with_iron.init()

    return {
        description = "Ordinary stone with iron as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_iron"},
    }

end

function unilib.pkg.ore_default_stone_ordinary_with_iron.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 12,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = unilib.y_max,
        y_min                   = 1025,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 7 * 7 * 7,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = -255,
    })

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 29,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 5,
        y_max                   = -256,
        y_min                   = unilib.y_min,
    })

end
