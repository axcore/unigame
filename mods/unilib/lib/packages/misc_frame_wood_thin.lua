---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_thin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_thin.init()

    return {
        description = "Thin wooden frame",
        depends = {"glass_ordinary", "item_stick_ordinary"},
    }

end

function unilib.pkg.misc_frame_wood_thin.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node(
        -- From GLEMr6, lib_materials:glass_framed_wood_02
        "unilib:misc_frame_wood_thin",
        "lib_materials:glass_framed_wood_02",
        mode,
        {
            description = S("Thin Wooden Frame"),
            tiles = {"unilib_misc_frame_wood_thin.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.sound_table.glass,

            drawtype = "glasslike_framed",
            paramtype = "light",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_wood_thin 2",
        recipe = {
            {c_stick, "", c_stick},
            {"", "unilib:glass_ordinary", ""},
            {c_stick, "", c_stick},
        },
    })

end
