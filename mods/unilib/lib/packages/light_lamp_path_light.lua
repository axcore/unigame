---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_path_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_path_light.init()

    return {
        description = "Light modern path light",
        depends = {"dye_basic", "light_bulb_normal", "metal_steel"},
    }

end

function unilib.pkg.light_lamp_path_light.exec()

    unilib.register_node("unilib:light_lamp_path_light", "morelights_modern:pathlight_l", mode, {
        -- From morelights_modern:pathlight_l
        description = S("Light Modern Path Light"),
        tiles = {"unilib_hardware_pole_metal_light.png^unilib_light_lamp_path_overlay.png"},
        groups = {cracky = 3, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 8,
        node_box = {
            type = "fixed",
            fixed = {
                {-1/32, -8/16, -1/32, 1/32, 1/8, 1/32},
                {-1/16, 1/8, -1/16, 1/16, 5/16, 1/16},
                {-1/8, 5/16, -1/8, 1/8, 3/8, 1/8},
            },
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
        output = "unilib:light_lamp_path_light",
        recipe = {
            {"unilib:dye_white", "unilib:light_bulb_normal", ""},
            {"", "unilib:metal_steel", ""},
            {"", "unilib:metal_steel", ""},
        },
    })

end
