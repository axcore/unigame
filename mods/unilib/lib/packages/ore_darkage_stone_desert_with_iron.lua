---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_darkage_stone_desert_with_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_darkage_stone_desert_with_iron.init()

    return {
        description = "Desert stone with iron as ore",
        depends = {"stone_desert", "stone_desert_with_iron"},
    }

end

function unilib.pkg.ore_darkage_stone_desert_with_iron.post()

    unilib.register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_desert_with_iron",
        wherein                 = "unilib:stone_desert",

        clust_num_ores          = 3,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 2,
        y_max                   = 200,
        y_min                   = -1,
    })

end
