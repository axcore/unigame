---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_moreores_stone_ordinary_with_mithril = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_moreores_stone_ordinary_with_mithril.init()

    return {
        description = "Ordinary stone with mithril as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_mithril"},
    }

end

function unilib.pkg.ore_moreores_stone_ordinary_with_mithril.post()

    unilib.register_ore({
        -- From moreores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mithril",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 1,
        clust_scarcity          = 1331,
        clust_size              = 11,
        y_max                   = -512,
        y_min                   = unilib.y_min,
    })

end
