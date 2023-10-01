---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_street_light = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_street_light.init()

    return {
        description = "Light-coloured street lights",
        notes = "Connects to metal street poles",
        depends = {"glass_ordinary", "metal_copper", "metal_steel"},
    }

end

function unilib.pkg.light_lamp_street_light.exec()

    unilib.register_node("unilib:light_lamp_street_light_connecting", nil, mode, {
        -- Original to unilib, adapted from morelights_modern:barlight_c
        description = unilib.brackets(S("Light-Coloured Street Light"), S("Connecting")),
        tiles = {
            "unilib_pole_metal_light.png",
            "unilib_light_lamp_street.png",
            "unilib_pole_metal_light.png"
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sound = unilib.sound_table.glass,

        connects_to = {
            "unilib:light_lamp_street_light_connecting",
            "unilib:light_lamp_street_light_straight",
            "unilib:pole_metal_dark_street",
            "unilib:pole_metal_light_street"
        },
        drawtype = "nodebox",
        light_source = unilib.light_max,
        node_box = {
            type = "connected",
            fixed = {-1/8,  3/8, -1/8, 1/8,  1/2, 1/8},
            connect_front = {-1/8, 3/8, -1/2, 1/8,  1/2, -1/8},
            connect_left = {-1/2, 3/8, -1/8, -1/8, 1/2, 1/8},
            connect_back = {-1/8, 3/8, 1/8, 1/8, 1/2, 1/2},
            connect_right = {1/8, 3/8, -1/8, 1/2, 1/2, 1/8},
        },
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- Original to unilib, adapted from morelights_modern:barlight_c
        output = "unilib:light_lamp_street_light_connecting 4",
        recipe = {
            {"unilib:metal_copper_ingot", "unilib:metal_copper_ingot", "unilib:metal_copper_ingot"},
            {"unilib:metal_steel_ingot", "unilib:glass_ordinary", "unilib:metal_steel_ingot"}
        }
    })
    unilib.register_craft({
        -- Original to unilib, adapted from morelights_modern:barlight_c
        type = "shapeless",
        output = "unilib:light_lamp_street_light_connecting",
        recipe = {"unilib:light_lamp_street_light_straight"},
    })

    unilib.register_node("unilib:light_lamp_street_light_straight", nil, mode, {
        -- Original to unilib, adapted from morelights_modern:barlight_S
        description = unilib.brackets(S("Light-Coloured Street Light"), S("Straight")),
        tiles = {
            "unilib_pole_metal_light.png",
            "unilib_light_lamp_street.png",
            "unilib_pole_metal_light.png"
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sound = unilib.sound_table.glass,

        drawtype = "nodebox",
        light_source = unilib.light_max,
        node_box = {
            type = "fixed",
            fixed = {-1/2, 3/8, -1/8, 1/2, 1/2, 1/8},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- Original to unilib, adapted from morelights_modern:barlight_S
        type = "shapeless",
        output = "unilib:light_lamp_street_light_straight",
        recipe = {"unilib:light_lamp_street_light_connecting"}
    })

end
