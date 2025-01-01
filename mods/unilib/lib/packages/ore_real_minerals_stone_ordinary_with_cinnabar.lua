---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_real_minerals_stone_ordinary_with_cinnabar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_real_minerals_stone_ordinary_with_cinnabar.init()

    return {
        description = "Ordinary stone with cinnabar as ore",
        depends = {"stone_ordinary", "stone_ordinary_with_cinnabar"},
    }

end

function unilib.pkg.ore_real_minerals_stone_ordinary_with_cinnabar.post()

    unilib.register_ore({
        -- From real_minerals/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_cinnabar",
        wherein                 = "unilib:stone_ordinary",

        clust_num_ores          = 10,
        clust_scarcity          = 54,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = 19,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 1.2,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

end

