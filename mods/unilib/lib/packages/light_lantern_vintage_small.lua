---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_vintage_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_vintage_small.init()

    return {
        description = "Small vintage lantern",
        depends = {"light_bulb_normal", "pane_glass_ordinary", "tree_jungle"},
    }

end

function unilib.pkg.light_lantern_vintage_small.exec()

    local c_pane = "unilib:pane_glass_ordinary_flat"
    local c_wood = "unilib:tree_jungle_wood"

    unilib.register_node(
        -- From morelights_vintage:smallblock
        "unilib:light_lantern_vintage_small",
        "morelights_vintage:smallblock",
        mode,
        {
            description = S("Small Vintage Lantern"),
            tiles = {
                "unilib_light_lantern_vintage.png^unilib_light_lantern_vintage_overlay.png",
                "unilib_light_lantern_vintage.png^unilib_light_lantern_vintage_overlay.png",
                "[combine:16x16:0,4=" ..
                    "(unilib_light_lantern_vintage.png^unilib_light_lantern_vintage_overlay.png)",
            },
            groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "nodebox",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            light_source = 12,
            node_box = {
                type = "fixed",
                fixed = {-1/4, -1/2, -1/4, 1/4, 0, 1/4},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "opaque",

            on_place = function(itemstack, placer, pointed_thing)
                return unilib.misc.rotate_and_place(itemstack, placer, pointed_thing)
            end
        }
    )
    unilib.register_craft({
        -- From morelights_vintage:smallblock
        output = "unilib:light_lantern_vintage_small",
        recipe = {
            {"", c_pane, ""},
            {c_wood, "unilib:light_bulb_normal", c_wood}
        },
    })

end
