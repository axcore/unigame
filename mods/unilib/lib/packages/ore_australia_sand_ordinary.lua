---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_australia_sand_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_australia_sand_ordinary.init()

    return {
        description = "Ordinary sand as ore",
        depends = {"sand_ordinary", "stone_ordinary", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.ore_australia_sand_ordinary.post()

    unilib.register_ore({
        -- From australia/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:sand_ordinary",
        wherein                 = {"unilib:stone_ordinary", "unilib:stone_sandstone_ordinary"},

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
        y_max                   = 4,
        y_min                   = -31,
    })

end
