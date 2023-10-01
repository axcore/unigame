---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_stone_savanna_with_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_savanna_with_coal.init()

    return {
        description = "Savanna stone with coal as ore",
        depends = {"stone_savanna", "stone_savanna_with_coal"},
    }

end

function unilib.pkg.ore_farlands_stone_savanna_with_coal.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_savanna_with_coal",
        wherein                 = "unilib:stone_savanna",

        clust_num_ores          = 9,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        y_max                   = unilib.y_max,
        y_min                   = -1025,
    })

end
