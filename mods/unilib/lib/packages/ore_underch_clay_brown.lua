---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_underch_clay_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_underch_clay_brown.init()

    return {
        description = "Brown clay as ore",
        depends = {"clay_brown", "stone_ordinary"},
    }

end

function unilib.pkg.ore_underch_clay_brown.exec()

    unilib.register_ore({
        -- From underch/init.lua
        ore_type                = "blob",
        ore                     = "unilib:clay_brown",
        wherein                 = "unilib:stone_ordinary",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = 4913,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = -93,
    })

end
