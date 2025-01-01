---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_stone_ordinary_with_fossil_bone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_ordinary_with_fossil_bone.init()

    return {
        description = "Ordinary stone with bone fossil as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_fossil_bone"},
    }

end

function unilib.pkg.ore_farlands_stone_ordinary_with_fossil_bone.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_fossil_bone",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 1,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 1,
        -- N.B. Original y_max/y_min makes no sense, so changed them
--      y_max                   = unilib.constant.y_max,
--      y_min                   = 625,
        y_max                   = -625,
        y_min                   = unilib.constant.y_min,
    })

end
