---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_steel_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_steel_simple.init()

    return {
        description = "Steel-framed glass",
        notes = "This GLEMr6 item seems to have been adapted from unilib:misc_frame_steel_ornate" ..
                " (originally from nbea)",
        depends = {"item_stick_ordinary", "metal_steel"},
    }

end

function unilib.pkg.misc_frame_steel_simple.exec()

    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node(
        -- From GLEMr6, lib_materials:glass_framed_steel_01
        "unilib:misc_frame_steel_simple",
        "lib_materials:glass_framed_steel_01",
        mode,
        {
            description = S("Simple Steel-Framed Glass"),
            tiles = {"unilib_misc_frame_steel_ornate_overlay.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            drawtype = "glasslike_framed",
            -- N.B. is_ground_content = false not in original code; added to match other frames
            is_ground_content = false,
            paramtype = "light",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_steel_simple 2",
        recipe = {
            {c_steel, c_steel, c_steel},
            {c_steel, "unilib:item_stick_ordinary", c_steel},
            {c_steel, c_steel, c_steel},
        },
    })

end
