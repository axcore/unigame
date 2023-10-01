---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_xtraores_stone_ordinary_with_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_xtraores_stone_ordinary_with_geminitinum.init()

    return {
        description = "Ordinary stone with geminitinum as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_geminitinum"},
    }

end

function unilib.pkg.ore_xtraores_stone_ordinary_with_geminitinum.post()

    unilib.register_ore({
        -- From xtraores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_geminitinum",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 42875,
        clust_size              = 3,
        flags                   = "absheight",
        -- N.B. .y_max is -32000 in original code; an invalid value, so let's assume the intention
        --      was -30000
--      y_max                   = -32000,
        y_max                   = -30000,
        y_min                   = unilib.y_min,
    })

end
