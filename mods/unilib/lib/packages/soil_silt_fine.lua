---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_silt_fine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_silt_fine.init()

    return {
        description = "Fine silt soil",
        depends = "dirt_silt_fine",
    }

end

function unilib.pkg.soil_silt_fine.exec()

    unilib.register_node("unilib:soil_silt_fine", nil, mode, {
        -- Original to unilib
        description = S("Fine Silt Soil"),
        tiles = {
            "unilib_dirt_silt_fine.png^unilib_soil_overlay.png",
            "unilib_dirt_silt_fine.png",
        },
        groups = {
            crumbly = 3, field = 1, not_in_creative_inventory = 1, regular_soil = 1, soil = 2,
            silt_soil = 1,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_silt_fine",
        soil = {
            base = "unilib:dirt_silt_fine",
            dry = "unilib:soil_silt_fine",
            wet = "unilib:soil_silt_fine_wet",
        },
    })

    unilib.register_node("unilib:soil_silt_fine_wet", nil, mode, {
        -- Original to unilib
        description = S("Wet Fine Silt Soil"),
        tiles = {
            "unilib_dirt_silt_fine.png^unilib_soil_wet_overlay.png",
            "unilib_dirt_silt_fine.png^unilib_soil_wet_side_overlay.png",
        },
        groups = {
            crumbly = 3, field = 1, not_in_creative_inventory = 1, regular_soil = 1, soil = 3,
            silt_soil = 1, wet = 1,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_silt_fine",
        soil = {
            base = "unilib:dirt_silt_fine",
            dry = "unilib:soil_silt_fine",
            wet = "unilib:soil_silt_fine_wet",
        },
    })

end
