---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_modern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_modern.init()

    return {
        description = "Modern lamp",
        depends = {"light_bulb_normal", "metal_steel", "pane_glass_ordinary"},
    }

end

function unilib.pkg.light_block_modern.exec()

    local c_pane = "unilib:pane_glass_ordinary_flat"

    unilib.register_node("unilib:light_block_modern", "morelights_modern:block", mode, {
        -- From morelights_modern:block
        description = S("Modern Light Block"),
        tiles = {"unilib_light_block_modern_frame.png^unilib_light_block_modern_overlay.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        light_source = unilib.light_max,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_modern:block
        output = "unilib:light_block_modern",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {c_pane, "unilib:light_bulb_normal", c_pane},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

    unilib.register_node(
        -- From morelights_modern:smallblock
        "unilib:light_block_modern_small",
        "morelights_modern:smallblock",
        mode,
        {
            description = S("Small Modern Light Block"),
            tiles = {
                "unilib_pole_metal_dark.png^unilib_light_block_modern_small_overlay.png",
                "unilib_pole_metal_dark.png^unilib_light_block_modern_small_overlay.png",
                "[combine:16x16:0,0=unilib_pole_metal_dark.png" ..
                        ":0,4=unilib_light_block_modern_small_overlay.png",
            },
            groups = {cracky = 3, handy = 1, oddly_breakable_by_hand = 3},
            unilib.sound_table.glass,

            drawtype = "nodebox",
            light_source = 12,
            node_box = {
                type = "fixed",
                fixed = {-1/4, -1/2, -1/4, 1/4, 0, 1/4},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,

            on_place = function(itemstack, placer, pointed_thing)
                return unilib.rotate_and_place(itemstack, placer, pointed_thing)
            end,
        }
    )
    unilib.register_craft({
        -- From morelights_modern:smallblock
        output = "unilib:light_block_modern_small",
        recipe = {
            {"", c_pane, ""},
            {"unilib:metal_steel_ingot", "morelights:bulb", "unilib:metal_steel_ingot"}
        }
    })

end
