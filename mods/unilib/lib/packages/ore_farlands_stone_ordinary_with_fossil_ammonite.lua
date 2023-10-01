---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_stone_ordinary_with_fossil_ammonite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_ordinary_with_fossil_ammonite.init()

    return {
        description = "Ordinary stone with ammonite fossil as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_fossil_ammonite"},
    }

end

function unilib.pkg.ore_farlands_stone_ordinary_with_fossil_ammonite.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_fossil_ammonite",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 1,
        clust_scarcity          = 24 * 24 * 24,
        clust_size              = 1,
        y_max                   = unilib.y_max,
        y_min                   = 625,
    })

end
