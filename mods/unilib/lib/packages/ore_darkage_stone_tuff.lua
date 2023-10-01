---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_darkage_stone_tuff = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_darkage_stone_tuff.init()

    return {
        description = "Tuff as ore",
        depends = "stone_tuff",
        at_least_one = {
            "dirt_ordinary",
            "gravel_ordinary",
            "stone_ordinary",
            "stone_ordinary_with_coal",
        },
    }

end

function unilib.pkg.ore_darkage_stone_tuff.post()

    unilib.register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff",
        wherein                 = {
            "unilib:dirt_ordinary",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
            "unilib:stone_ordinary_with_coal",
        },

        column_height_max       = 20,
        column_height_min       = 15,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persistence = 0.6,
            scale = 0.19,
            seed = minetest.get_mapgen_setting("seed") + 12,
            spread = {x = 45, y = 45, z = 45},
        },
        noise_threshold         = 0.5,
        y_max                   = 200,
        y_min                   = -200,
    })

end
