---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_table_light = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_table_light.init()

    return {
        description = "Light modern table lamp",
        depends = {"light_bulb_normal", "metal_steel", "wool_basic"},
    }

end

function unilib.pkg.light_lamp_table_light.exec()

    unilib.register_node("unilib:light_lamp_table_light", "morelights_modern:tablelamp_l", mode, {
        -- From morelights_modern:tablelamp_l
        description = S("Light Modern Table Lamp"),
        tiles = {
            "unilib_pole_metal_dark.png^unilib_light_lamp_table_bulb_overlay.png",
            "unilib_light_lamp_table_light.png",
        },
        groups = {choppy = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.node,

        collision_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4},
        },
        drawtype = "mesh",
        light_source = 10,
        mesh = "unilib_light_lamp_table.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4},
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From morelights_modern:tablelamp_d
        output = "unilib:light_lamp_table_dark",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:wool_white", "unilib:light_bulb_normal", "unilib:wool_white"},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

end
