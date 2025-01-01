---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple_mangrove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_apple_mangrove.init()

    return {
        description = "Mangrove apple",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_apple_mangrove.exec()

    unilib.register_node("unilib:fruit_apple_mangrove", "australia:mangrove_apple", mode, {
        -- From australia:mangrove_apple
        description = S("Mangrove Apple"),
        tiles = {"unilib_fruit_apple_mangrove.png"},
        -- N.B. no food_mangrove_apple in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_mangrove_apple = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_apple_mangrove.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.67,
        walkable = false,
        wield_image = "unilib_fruit_apple_mangrove.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_apple_mangrove", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_apple_mangrove", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:fruit_apple_mangrove"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_apple_mangrove",
        juice_description = S("Apple"),
        juice_type = "apple",
        rgb = "#ecff56",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_apple_mangrove.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_apple_mangrove",

        replace_mode = mode,
        leaves_list = {"unilib:tree_mangrove_apple_leaves"},
        pkg_list = {"tree_mangrove_apple"},
    })

end
