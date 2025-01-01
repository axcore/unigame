---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_vintage_bulb = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_vintage_bulb.init()

    return {
        description = "Vintage hanging light bulb",
        depends = {"light_bulb_normal", "metal_copper", "metal_steel"},
    }

end

function unilib.pkg.light_lamp_vintage_bulb.exec()

    unilib.register_node("unilib:light_lamp_vintage_bulb", "morelights_vintage:hangingbulb", mode, {
        -- From morelights_vintage:hangingbulb
        description = S("Vintage Hanging Light Bulb"),
        tiles = {
            "unilib_light_lamp_vintage_bulb.png^[lowpart:50:unilib_hardware_pole_metal_dark.png",
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {-1/8, -1/8, -1/8, 1/8, 1/2, 1/8},
        },
        drawtype = "mesh",
        inventory_image = "unilib_light_lamp_vintage_bulb_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 10,
        mesh = "unilib_light_lamp_vintage_bulb.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, -1/8, -1/8, 1/8, 1/2, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "blend",
        wield_image = "unilib_light_lamp_vintage_bulb_inv.png",
    })
    unilib.register_craft({
        -- From morelights_vintage:hangingbulb
        output = "unilib:light_lamp_vintage_bulb",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_copper_ingot", ""},
            {"", "unilib:light_bulb_normal", ""},
        },
    })

end
