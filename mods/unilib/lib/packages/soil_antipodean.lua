---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_antipodean.init()

    return {
        description = "Antipodean soil",
        depends = "dirt_antipodean",
    }

end

function unilib.pkg.soil_antipodean.exec()

    unilib.register_node("unilib:soil_antipodean", nil, mode, {
        -- Original to unilib
        description = S("Antipodean Soil"),
        tiles = {
            "unilib_dirt_antipodean.png^unilib_soil_antipodean_overlay.png",
            "unilib_dirt_antipodean.png",
        },
        groups = {
            antipodean_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, soil = 2,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_antipodean",
        soil = {
            base = "unilib:dirt_antipodean",
            dry = "unilib:soil_antipodean",
            wet = "unilib:soil_antipodean_wet",
        },
    })

    unilib.register_node("unilib:soil_antipodean_wet", nil, mode, {
        -- Original to unilib
        description = S("Wet Antipodean Soil"),
        tiles = {
            "unilib_dirt_antipodean.png^unilib_soil_antipodean_wet_overlay.png",
            "unilib_dirt_antipodean.png^unilib_soil_wet_side_overlay.png",
        },
        groups = {
            antipodean_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, soil = 3,
            wet = 1,
        },
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_antipodean",
        soil = {
            base = "unilib:dirt_antipodean",
            dry = "unilib:soil_antipodean",
            wet = "unilib:soil_antipodean_wet",
        },
    })

end
