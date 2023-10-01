---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pole_metal_light_street = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pole_metal_light_street.init()

    return {
        description = "Light street lamp post",
        depends = {"dye_basic", "metal_steel"},
    }

end

function unilib.pkg.pole_metal_light_street.exec()

    unilib.register_node(
        -- From morelights_modern:streetpost_l
        "unilib:pole_metal_light_street",
        "morelights_modern:streetpost_l",
        mode,
        {
            description = unilib.hint(S("Light Lamp Post"), S("connects to street lights")),
            tiles = {"unilib_pole_metal_light.png"},
            groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.metal,

            connects_to = {
                "unilib:light_lamp_street_light_connecting",
                "unilib:light_lamp_street_light_straight",
                "unilib:light_lamp_street_dark_connecting",
                "unilib:light_lamp_street_dark_straight",
            },
            drawtype = "nodebox",
            node_box = {
                type = "connected",
                fixed = {-1/16, -1/2, -1/16, 1/16,  1/2, 1/16},
                connect_front = {-1/16,  3/8, -1/2, 1/16,  7/16, -1/16},
                connect_left = {-1/2, 3/8, -1/16, -1/16, 7/16, 1/16},
                connect_back = {-1/16, 3/8, 1/16, 1/16, 7/16, 1/2},
                connect_right = {1/16, 3/8, -1/16, 1/2, 7/16, 1/16},
            },
            paramtype = "light",
            sunlight_propagates = true,
        }
    )
    unilib.register_craft({
        -- From morelights_modern:streetpost_l
        output = "unilib:pole_metal_light_street 2",
        recipe = {
            {"unilib:dye_white", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

end
