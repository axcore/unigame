---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_xtraores_stone_ordinary_with_sybilline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_xtraores_stone_ordinary_with_sybilline.init()

    return {
        description = "Ordinary stone with sybilline as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_sybilline"},
    }

end

function unilib.pkg.ore_xtraores_stone_ordinary_with_sybilline.post()

    unilib.register_ore({
        -- From xtraores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_sybilline",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 5,
        clust_scarcity          = 8000,
        clust_size              = 3,
        flags                   = "absheight",
        y_max                   = -1000,
        y_min                   = unilib.y_min,
    })

end
