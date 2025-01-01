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

unilib.pkg.ore_farlands_stone_ordinary_with_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_ordinary_with_tin.init()

    return {
        description = "Ordinary stone with tin as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_tin"},
    }

end

function unilib.pkg.ore_farlands_stone_ordinary_with_tin.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 12,
        clust_scarcity          = 30 * 30 * 30,
        clust_size              = 3,
        y_max                   = 1025,
        y_min                   = -1000,
    })

end
