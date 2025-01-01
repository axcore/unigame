---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_can_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_can_light.init()

    return {
        description = "Light modern can light",
        depends = {"dye_basic", "light_bulb_normal", "metal_steel"},
    }

end

function unilib.pkg.light_lamp_can_light.exec()

    unilib.register_node("unilib:light_lamp_can_light", "morelights_modern:canlight_l", mode, {
        -- From morelights_modern:canlight_l
        description = S("Light Modern Can Light"),
        tiles = {"unilib_hardware_pole_metal_light.png^unilib_light_lamp_can_overlay.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {-1/8, 0, -1/8, 1/8, 1/2, 1/8},
        },
        drawtype = "mesh",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 12,
        mesh = "unilib_light_lamp_can.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, 0, -1/8, 1/8, 1/2, 1/8},
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From morelights_modern:canlight_l
        output = "unilib:light_lamp_can_light",
        recipe = {
            {"unilib:dye_white", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "unilib:light_bulb_normal", "unilib:metal_steel_ingot"},
        },
    })

end
