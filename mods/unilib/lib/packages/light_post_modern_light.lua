---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_post_modern_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_post_modern_light.init()

    return {
        description = "Light modern light post",
        depends = {"dye_basic", "light_bulb_normal", "metal_steel"},
    }

end

function unilib.pkg.light_post_modern_light.exec()

    unilib.register_node("unilib:light_post_modern_light", "morelights_modern:post_l", mode, {
        -- From morelights_modern:post_l
        description = S("Light-Coloured Modern Light Post"),
        tiles = {
            "unilib_hardware_pole_metal_light.png",
            "unilib_hardware_pole_metal_light.png",
            "unilib_hardware_pole_metal_light.png^unilib_light_post_modern_overlay.png",
        },
        groups = {cracky = 3, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = unilib.constant.light_max,
        node_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
        },
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From morelights_modern:post_l
        output = "unilib:light_post_modern_light",
        recipe = {
            {"unilib:dye_white", "unilib:metal_steel_ingot", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

end
