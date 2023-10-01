---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_vintage = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_vintage.init()

    return {
        description = "Vintage lamp",
        depends = {
            "light_bulb_normal", "item_stick_ordinary", "metal_steel", "pane_glass_ordinary",
        },
    }

end

function unilib.pkg.light_lamp_vintage.exec()

    local c_pane = "unilib:pane_glass_ordinary_flat"
    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:light_lamp_vintage_floor", "morelights_vintage:lantern_f", mode, {
        -- From morelights_vintage:lantern_f
        description = unilib.hint(S("Vintage Lamp"), S("floor, wall or ceiling")),
        tiles = {
            "unilib_light_lamp_vintage_overlay.png^unilib_light_lamp_vintage.png",
            "unilib_pole_metal_dark.png"
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        unilib.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16},
        },
        drawtype = "mesh",
        light_source = 12,
        mesh = "unilib_light_lamp_vintage_floor.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16},
        },
        sunlight_propagates = true,
        use_texture_alpha = "opaque",

        on_place = function(itemstack, placer, pointed_thing)

            local wdir = minetest.dir_to_wallmounted(
                vector.subtract(pointed_thing.under, pointed_thing.above)
            )
            local fakestack = ItemStack(itemstack)

            if wdir == 0 then
                fakestack:set_name("unilib:light_lamp_vintage_ceiling")
            elseif wdir == 1 then
                fakestack:set_name("unilib:light_lamp_vintage_floor")
            else
                fakestack:set_name("unilib:light_lamp_vintage_wall")
            end

            minetest.item_place(fakestack, placer, pointed_thing, wdir)
            itemstack:set_count(fakestack:get_count())

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From morelights_vintage:lantern_f
        output = "unilib:light_lamp_vintage_floor",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {c_pane, "unilib:light_bulb_normal", c_pane},
            {c_stick, "unilib:metal_steel_ingot", c_stick}
        }
    })

    unilib.register_node(
        -- From morelights_vintage:lantern_c
        "unilib:light_lamp_vintage_ceiling",
        "morelights_vintage:lantern_c",
        mode,
        {
            -- (no description)
            tiles = {
                "unilib_light_lamp_vintage_overlay.png^unilib_light_lamp_vintage.png",
                "unilib_pole_metal_dark.png"
            },
            groups = {
                cracky = 2, handy = 1, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3,
            },
            sounds = unilib.sound_table.glass,

            collision_box = {
                type = "fixed",
                fixed = {-3/16, -1/16, -3/16, 3/16, 1/2, 3/16},
            },
            drawtype = "mesh",
            drop = "unilib:light_lamp_vintage_floor",
            light_source = 12,
            mesh = "unilib_light_lamp_vintage_ceiling.obj",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-3/16, 0, -3/16, 3/16, 1/2, 3/16},
            },
            sunlight_propagates = true,
            use_texture_alpha = "opaque",
        }
    )

    unilib.register_node("unilib:light_lamp_vintage_wall", "morelights_vintage:lantern_w", mode, {
        -- From morelights_vintage:lantern_w
        -- (no description)
        tiles = {
            "unilib_light_lamp_vintage_overlay.png^unilib_light_lamp_vintage.png",
            "unilib_pole_metal_dark.png"
        },
        groups = {
            cracky = 2, handy = 1, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3,
        },
        sounds = unilib.sound_table.glass,

        collision_box = {
            type = "fixed",
            fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16},
        },
        drawtype = "mesh",
        drop = "unilib:light_lamp_vintage_floor",
        light_source = 12,
        mesh = "unilib_light_lamp_vintage_wall.obj",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })

end
