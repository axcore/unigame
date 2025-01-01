---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_underch_gravel_mossy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_underch_gravel_mossy.init()

    return {
        description = "Mossy gravel as ore",
        depends = {"gravel_mossy", "stone_ordinary"},
    }

end

function unilib.pkg.ore_underch_gravel_mossy.post()

    unilib.register_ore({
        -- From underch/init.lua
        ore_type                = "blob",
        ore                     = "unilib:gravel_mossy",
        wherein                 = "unilib:stone_ordinary",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = 9741,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1301,
    })

end
