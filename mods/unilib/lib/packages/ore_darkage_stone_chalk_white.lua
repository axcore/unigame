---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_darkage_stone_chalk_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_darkage_stone_chalk_white.init()

    return {
        description = "White chalk as ore",
        depends = {"stone_chalk_white", "stone_ordinary"},
    }

end

function unilib.pkg.ore_darkage_stone_chalk_white.post()

    unilib.register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_chalk_white",
        wherein                 = "unilib:stone_ordinary",

        column_height_max       = 30,
        column_height_min       = 20,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persistence = 0.6,
            scale = 0.2,
            spread = {x = 30, y = 30, z = 30},
        },
        noise_threshold         = 0.45,
        y_max                   = 50,
        y_min                   = -20,
    })

end
