---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_stone_ordinary_with_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_ordinary_with_iron.init()

    return {
        description = "Ordinary stone with iron as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_iron"},
    }

end

function unilib.pkg.ore_farlands_stone_ordinary_with_iron.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
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
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 7 * 7 * 7,
        clust_size              = 3,
        y_max                   = 0,
        y_min                   = unilib.y_min,
    })

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 27,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 6,
        y_max                   = -64,
        y_min                   = unilib.y_min,
    })

end
