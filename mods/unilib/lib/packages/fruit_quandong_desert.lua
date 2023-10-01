---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_quandong_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_quandong_desert.init()

    return {
        description = "Desert quandong (fruit)",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_quandong_desert.exec()

    unilib.register_node("unilib:fruit_quandong_desert", "australia:quandong", mode, {
        -- From australia:quandong
        description = S("Desert Quandong"),
        tiles = {"unilib_fruit_quandong_desert.png"},
        -- N.B. no food_desert_quandong in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_desert_quandong = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_quandong_desert.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.5,
        walkable = false,
        wield_image = "unilib_fruit_quandong_desert.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_quandong_desert", param2 = 1})
            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_quandong_desert", 1),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_quandong_desert"},
            },
        })

    end

end

function unilib.pkg.fruit_quandong_desert.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_quandong_desert",

        replace_mode = mode,
        leaves_list = {"unilib:tree_quandong_desert_leaves"},
        pkg_list = {"tree_quandong_desert"},
    })

end
