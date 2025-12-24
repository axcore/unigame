---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_brown.init()

    return {
        description = "Brown soil",
        depends = "dirt_brown",
    }

end

function unilib.pkg.soil_brown.exec()

    unilib.register_node("unilib:soil_brown", nil, mode, {
        -- Original to unilib
        description = S("Brown Soil"),
        tiles = {
            "unilib_dirt_brown.png^unilib_soil_brown_overlay.png",
            "unilib_dirt_brown.png",
        },
        groups = {brown_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, soil = 2},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_brown",
        soil = {
            base = "unilib:dirt_brown",
            dry = "unilib:soil_brown",
            wet = "unilib:soil_brown_wet",
        },
    })

    unilib.register_node("unilib:soil_brown_wet", nil, mode, {
        -- Original to unilib
        description = S("Wet Brown Soil"),
        tiles = {
            "unilib_dirt_brown.png^unilib_soil_brown_wet_overlay.png",
            "unilib_dirt_brown.png^unilib_soil_wet_side_overlay.png",
        },
        groups = {
            brown_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, soil = 3,
            wet = 1,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_brown",
        soil = {
            base = "unilib:dirt_brown",
            dry = "unilib:soil_brown",
            wet = "unilib:soil_brown_wet",
        },
    })

end
