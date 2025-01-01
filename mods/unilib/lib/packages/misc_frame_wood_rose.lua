---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_rose = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_rose.init()

    return {
        description = "Wooden rose frame",
        depends = {"glass_ordinary", "item_stick_ordinary", "tree_jungle"},
    }

end

function unilib.pkg.misc_frame_wood_rose.exec()

    local c_stick = "unilib:item_stick_ordinary"
    local c_wood = "unilib:tree_jungle_wood"

    unilib.register_node("unilib:misc_frame_wood_rose", "lib_materials:frame_wood_rose", mode, {
        -- From GLEMr6, lib_materials:frame_wood_rose
        description = S("Wooden Rose Frame"),
        tiles = {"unilib_misc_frame_wood_rose.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed",
        -- N.B. is_ground_content = false not in original code; added to match other frames
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_wood_rose 2",
        recipe = {
            {c_wood, c_stick, c_wood},
            {c_stick, "unilib:glass_ordinary", c_stick},
            {c_wood, c_stick, c_wood},
        },
    })

end
