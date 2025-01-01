---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_screen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_screen.init()

    return {
        description = "Wooden screen frame",
    }

end

function unilib.pkg.misc_frame_wood_screen.exec()

    unilib.register_node("unilib:misc_frame_wood_screen", "lib_materials:frame_wood_screen", mode, {
        -- From GLEMr6, lib_materials:frame_wood_screen
        description = S("Wooden Screen Frame"),
        tiles = {"unilib_misc_frame_wood_screen.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed",
        -- N.B. is_ground_content = false not in original code; added to match other frames
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })

end
