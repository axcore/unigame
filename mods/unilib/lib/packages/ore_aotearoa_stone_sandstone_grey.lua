---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_sandstone_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_sandstone_grey.init()

    return {
        description = "Grey sandstone as ore",
        depends = {"stone_sandstone_grey", "stone_sandstone_pale"},
    }

end

function unilib.pkg.ore_aotearoa_stone_sandstone_grey.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_sandstone_grey",
        wherein                 = "unilib:stone_sandstone_pale",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 20,
        noise_params            = {
            octaves = 2,
            offset = 0,
            persist = 0.4,
            scale = 1,
            seed = -1009674,
            spread = {x = 15, y = 15, z = 15},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

end
