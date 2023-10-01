---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_path_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_path_dark.init()

    return {
        description = "Dark modern path light",
        depends = {"dye_basic", "light_bulb_normal", "metal_steel"},
    }

end

function unilib.pkg.light_lamp_path_dark.exec()

    unilib.register_node("unilib:light_lamp_path_dark", "morelights_modern:pathlight_d", mode, {
        -- From morelights_modern:pathlight_d
        description = S("Dark Modern Path Light"),
        tiles = {"unilib_pole_metal_dark.png^unilib_light_lamp_path_overlay.png"},
        groups = {cracky = 3, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        light_source = 8,
        node_box = {
            type = "fixed",
            fixed = {
                {-1/32, -8/16, -1/32, 1/32, 1/8, 1/32},
                {-1/16, 1/8, -1/16, 1/16, 5/16, 1/16},
                {-1/8, 5/16, -1/8, 1/8, 3/8, 1/8},
            }
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 3/8, 1/8},
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From morelights_modern:pathlight_d
        output = "unilib:light_lamp_path_dark",
        recipe = {
            {"unilib:dye_grey_dark", "unilib:light_bulb_normal", ""},
            {"", "unilib:metal_steel", ""},
            {"", "unilib:metal_steel", ""},
        },
    })

end
