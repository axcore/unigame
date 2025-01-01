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

unilib.pkg.ore_farlands_stone_ordinary_with_coal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_ordinary_with_coal.init()

    return {
        description = "Ordinary stone with coal as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_coal"},
    }

end

function unilib.pkg.ore_farlands_stone_ordinary_with_coal.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 9,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        y_max                   = 64,
        y_min                   = unilib.constant.y_min,
    })

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 27,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 6,
        y_max                   = 0,
        y_min                   = unilib.constant.y_min,
    })

end
