---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_dark.init()

    return {
        description = "Dark soil",
        depends = "dirt_dark",
    }

end

function unilib.pkg.soil_dark.exec()

    unilib.register_node("unilib:soil_dark", nil, mode, {
        -- Original to unilib
        description = S("Dark Soil"),
        tiles = {
            "unilib_dirt_dark.png^unilib_soil_overlay.png",
            "unilib_dirt_dark.png",
        },
        groups = {crumbly = 3, dark_soil = 1, field = 1, not_in_creative_inventory = 1, soil = 2},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_dark",
        soil = {
            base = "unilib:dirt_dark",
            dry = "unilib:soil_dark",
            wet = "unilib:soil_dark_wet",
        },
    })

    unilib.register_node("unilib:soil_dark_wet", nil, mode, {
        -- Original to unilib
        description = S("Wet Dark Soil"),
        tiles = {
            "unilib_dirt_dark.png^unilib_soil_wet_overlay.png",
            "unilib_dirt_dark.png^unilib_soil_wet_side_overlay.png",
        },
        groups = {
            crumbly = 3, dark_soil = 1, field = 1, not_in_creative_inventory = 1, soil = 3,
            wet = 1,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_dark",
        soil = {
            base = "unilib:dirt_dark",
            dry = "unilib:soil_dark",
            wet = "unilib:soil_dark_wet",
        },
    })

end
