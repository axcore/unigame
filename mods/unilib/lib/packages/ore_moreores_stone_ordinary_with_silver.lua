---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_moreores_stone_ordinary_with_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_moreores_stone_ordinary_with_silver.init()

    return {
        description = "Ordinary stone with silver as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_silver"},
    }

end

function unilib.pkg.ore_moreores_stone_ordinary_with_silver.post()

    unilib.register_ore({
        -- From moreores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 4,
        clust_scarcity          = 1331,
        clust_size              = 11,
        y_max                   = -2,
        y_min                   = unilib.y_min,
    })

end
