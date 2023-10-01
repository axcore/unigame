---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_iron_rustic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_iron_rustic.init()

    return {
        description = "Rustic iron frame",
        depends = {"glass_ordinary", "item_stick_iron"},
    }

end

function unilib.pkg.misc_frame_iron_rustic.exec()

    unilib.register_node("unilib:misc_frame_iron_rustic", nil, mode, {
        -- Original to unilib
        description = S("Iron Frame"),
        tiles = {"unilib_misc_frame_iron_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 3, snappy = 1},
        sounds = unilib.sound_table.metal,

        drawtype = "glasslike_framed",
        inventory_image = "unilib_misc_frame_iron_rustic.png",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = "unilib_misc_frame_iron_rustic.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_iron_rustic",
        recipe = {
            {"unilib:item_stick_iron",    "", "unilib:item_stick_iron"},
            {"", "unilib:glass_ordinary", ""},
            {"unilib:item_stick_iron",    "", "unilib:item_stick_iron"},
        }
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:glass_ordinary",
        recipe = "unilib:misc_frame_iron_rustic",
    })

end
