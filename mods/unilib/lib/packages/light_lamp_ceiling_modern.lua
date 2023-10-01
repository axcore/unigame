---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_ceiling_modern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_ceiling_modern.init()

    return {
        description = "Modern ceiling light",
        depends = {"light_bulb_normal", "metal_steel", "pane_glass_ordinary"},
    }

end

function unilib.pkg.light_lamp_ceiling_modern.exec()

    unilib.register_node(
        -- From morelights_modern:ceilinglight
        "unilib:light_lamp_ceiling_modern",
        "morelights_modern:ceilinglight",
        mode,
        {
            description = S("Modern Ceiling Light"),
            tiles = {
                "unilib_pole_metal_dark.png",
                "unilib_pole_metal_dark.png^unilib_light_lamp_ceiling_modern_overlay.png"
            },
            groups = {cracky = 3, handy = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            drawtype = "nodebox",
            light_source = unilib.light_max,
            node_box = {
                type = "fixed",
                fixed = {-1/4, 3/8, -1/4, 1/4, 1/2, 1/4},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,

            on_place = function(itemstack, placer, pointed_thing)

                return unilib.rotate_and_place(
                    itemstack, placer, pointed_thing, {[0] = 0, 20, 12, 16, 4, 8}
                )

            end,
        }
    )
    unilib.register_craft({
        -- From morelights_modern:ceilinglight
        output = "unilib:light_lamp_ceiling_modern",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:light_bulb_normal", "unilib:metal_steel_ingot"},
            {"", "unilib:pane_glass_ordinary_flat", ""},
        },
    })

end
