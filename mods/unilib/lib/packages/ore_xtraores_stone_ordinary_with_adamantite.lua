---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_xtraores_stone_ordinary_with_adamantite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_xtraores_stone_ordinary_with_adamantite.init()

    return {
        description = "Ordinary stone with adamantite as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_adamantite"},
    }

end

function unilib.pkg.ore_xtraores_stone_ordinary_with_adamantite.post()

    unilib.register_ore({
        -- From xtraores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_adamantite",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 21952,
        clust_size              = 3,
        flags                   = "absheight",
        y_max                   = -5000,
        y_min                   = unilib.constant.y_min,
    })

end
