---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_darkage_stone_sandstone_old_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_darkage_stone_sandstone_old_red.init()

    return {
        description = "Old red sandstone as ore",
        depends = "stone_sandstone_old_red",
        at_least_one = {
            "dirt_ordinary",
            "gravel_ordinary",
            "stone_ordinary",
            "stone_ordinary_with_coal",
        },
    }

end

function unilib.pkg.ore_darkage_stone_sandstone_old_red.post()

    unilib.register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = {
            "unilib:dirt_ordinary",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
            "unilib:stone_ordinary_with_coal",
        },

        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persistence = 0.6,
            scale = 0.3,
            seed = minetest.get_mapgen_setting("seed") + 4,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

end
