---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_default_sand_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_default_sand_silver.init()

    return {
        description = "Silver sand as ore",
        depends = {"sand_silver", "stone_ordinary"},
    }

end

function unilib.pkg.ore_default_sand_silver.post()

    unilib.register_ore({
        -- From default/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:sand_silver",
        wherein                 = "unilib:stone_ordinary",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = 2316,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
