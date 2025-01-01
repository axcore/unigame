---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_wall = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_wall.init()

    return {
        description = "Modern wall lamp",
        depends = {"dye_basic", "light_bulb_normal", "metal_steel", "pane_glass_ordinary"},
    }

end

function unilib.pkg.light_lamp_wall.exec()

    unilib.register_node("unilib:light_lamp_wall", "morelights_modern:walllamp", mode, {
        -- From morelights_modern:walllamp
        description = S("Modern Wall Lamp"),
        tiles = {"unilib_hardware_pole_metal_dark.png^unilib_light_lamp_wall_overlay.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2},
        },
        drawtype = "mesh",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 12,
        mesh = "unilib_light_lamp_wall.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2},
        },
        sunlight_propagates = true,

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.rotate_and_place(
                itemstack, placer, pointed_thing, {[0] = 6, 4, 1, 3, 0, 2}
            )

        end
    })
    unilib.register_craft({
        -- From morelights_modern:walllamp
        output = "unilib:light_lamp_wall",
        recipe = {
            {
                "",
                "unilib:pane_glass_ordinary_flat",
                "",
            },
            {
                "unilib:pane_glass_ordinary_flat",
                "unilib:light_bulb_normal",
                "unilib:metal_steel_ingot",
            },
            {
                "",
                "unilib:dye_grey_dark",
                "unilib:metal_steel_ingot",
            },
        },
    })

end
