---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_brush_basting = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_brush_basting.init()

    return {
        description = "Basting brush",
        depends = {"crop_cotton", "item_stick_ordinary", "metal_tin", "shared_bbq"},
    }

end

function unilib.pkg.utensil_brush_basting.exec()

    unilib.register_node("unilib:utensil_brush_basting", "bbq:basting_brush", mode, {
        -- From bbq:basting_brush
        description = S("Basting Brush"),
        tiles = {"unilib_utensil_brush_basting_hang.png"},
        groups = {cracky = 1, dig_immediate = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_utensil_brush_basting.png",
        -- N.B. is_ground_content = false not in original code; added to match other utensil and
        --      vessel packages
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.085, -0.45, 0.5, 0.085, -.2525, 0.45},
                {-0.0625, -0.2525, 0.5, 0.0625, -.218, 0.45},
                {-0.03, -0.218, 0.5, 0.03, 0.0, 0.45},
                {-0.0625, 0.0, 0.5, 0.0625, 0.465, 0.45},
                {-0.03, .465, 0.5, 0.03, .5, 0.45},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        wield_image = "unilib_utensil_brush_basting.png",

        on_use = unilib.pkg.shared_bbq.on_use_play_sound("unilib_bbq_brush_basting"),
    })
    unilib.register_craft({
        -- From bbq:basting_brush
        output = "unilib:utensil_brush_basting",
        recipe = {
            {"", "unilib:crop_cotton_harvest", ""},
            {"", "unilib:metal_tin_ingot", ""},
            {"", "unilib:item_stick_ordinary", ""},
        },
    })

end
