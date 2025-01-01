---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_brush_grill = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_brush_grill.init()

    return {
        description = "Grill brush",
        depends = {"crop_cotton", "item_stick_ordinary", "metal_tin", "shared_bbq"},
    }

end

function unilib.pkg.utensil_brush_grill.exec()

    unilib.register_node("unilib:utensil_brush_grill", "bbq:grill_brush", mode, {
        -- From bbq:grill_brush
        description = S("Grill Brush"),
        tiles = {
            "unilib_utensil_brush_grill_hang_top.png",
            "unilib_utensil_brush_grill_hang.png",
        },
        groups = {cracky = 1, dig_immediate = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_utensil_brush_grill.png",
        -- N.B. is_ground_content = false not in original code; added to match other utensil and
        --      vessel packages
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.12, -0.5, 0.49, 0.12, -.467, 0.48},
                {-0.15, -0.467, 0.5, 0.15, -.2225, 0.45},
                {-0.125, -0.44, 0.5, 0.125, -.25, 0.35},
                {-0.03, -0.2225, 0.5, 0.03, 0.13, 0.45},
                {-0.0625, 0.13    , 0.5, 0.0625, 0.485, 0.45},
                {-0.03, .485, 0.5, 0.03, .5, 0.45},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        wield_image = "unilib_utensil_brush_grill.png",

        -- (The true argument specifies that this brush can only be used on a "cold" grill)
        on_use = unilib.pkg.shared_bbq.on_use_play_sound("unilib_bbq_brush_grill", true),
    })
    unilib.register_craft({
        -- From bbq:grill_brush
        output = "unilib:utensil_brush_grill",
        recipe = {
            {"", "unilib:metal_tin_ingot", "unilib:crop_cotton_harvest"},
            {"", "unilib:metal_tin_ingot", ""},
            {"", "unilib:item_stick_ordinary", ""},
        },
    })

end
