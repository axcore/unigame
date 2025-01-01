---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_ceiling_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.columnia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_ceiling_normal.init()

    return {
        description = "Normal ceiling lamp",
        depends = {"glass_ordinary", "metal_steel", "misc_blueprint_column", "torch_ordinary"},
    }

end

function unilib.pkg.light_lamp_ceiling_normal.exec()

    local c_blueprint = "unilib:misc_blueprint_column"

    unilib.register_node("unilib:light_lamp_ceiling_normal", "columnia:lamp_ceiling", mode, {
        -- From columnia:lamp_ceiling
        description = "Normal Ceiling Lamp",
        tiles = {
            "unilib_decor_block_metal_rusty.png",
            "unilib_light_lamp_ceiling_normal.png",
            "unilib_light_lamp_ceiling_normal.png",
            "unilib_light_lamp_ceiling_normal.png",
            "unilib_light_lamp_ceiling_normal.png",
            "unilib_light_lamp_ceiling_normal.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "nodebox",
        inventory_image = "unilib_light_lamp_ceiling_normal_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 13,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, 0.4375, -0.1875, 0.1875, 0.5, 0.1875},
                {-0.125, 0.375, -0.125, 0.125, 0.4375, 0.125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_craft({
        -- From columnia:lamp_ceiling
        output = "unilib:light_lamp_ceiling_normal 4",
        recipe = {
            {c_blueprint, "unilib:metal_steel_ingot", ""},
            {"", "unilib:torch_ordinary", ""},
            {"", "unilib:glass_ordinary", ""},
        },
        replacements = {
            {c_blueprint, c_blueprint},
        },
    })

    -- Code adapted from "light_lamp_ceiling_modern" package, so that the both ceiling lamps rotate
    --      on placement
    unilib.override_item("unilib:light_lamp_ceiling_normal", {
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.rotate_and_place(
                itemstack, placer, pointed_thing, {[0] = 0, 20, 12, 16, 4, 8}
            )

        end,
    })

end
