---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_black.init()

    return {
        description = "Black soil",
        depends = "dirt_black",
    }

end

function unilib.pkg.soil_black.exec()

    unilib.register_node("unilib:soil_black", nil, mode, {
        -- Original to unilib
        description = S("Black Soil"),
        tiles = {
            "unilib_dirt_black.png^unilib_soil_black_overlay.png",
            "unilib_dirt_black.png",
        },
        groups = {black_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, soil = 2},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_black",
        soil = {
            base = "unilib:dirt_black",
            dry = "unilib:soil_black",
            wet = "unilib:soil_black_wet",
        },
    })

    unilib.register_node("unilib:soil_black_wet", nil, mode, {
        -- Original to unilib
        description = S("Wet Black Soil"),
        tiles = {
            "unilib_dirt_black.png^unilib_soil_black_wet_overlay.png",
            "unilib_dirt_black.png^unilib_soil_wet_side_overlay.png",
        },
        groups = {
            black_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, soil = 3,
            wet = 1,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_black",
        soil = {
            base = "unilib:dirt_black",
            dry = "unilib:soil_black",
            wet = "unilib:soil_black_wet",
        },
    })

end
