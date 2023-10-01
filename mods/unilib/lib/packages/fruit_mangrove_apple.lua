---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_mangrove_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_mangrove_apple.init()

    return {
        description = "Mangrove apple",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_mangrove_apple.exec()

    unilib.register_node("unilib:fruit_mangrove_apple", "australia:mangrove_apple", mode, {
        -- From australia:mangrove_apple
        description = S("Mangrove Apple"),
        tiles = {"unilib_fruit_mangrove_apple.png"},
        -- N.B. no food_mangrove_apple in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_mangrove_apple = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_mangrove_apple.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.67,
        walkable = false,
        wield_image = "unilib_fruit_mangrove_apple.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_mangrove_apple", param2 = 1})
            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_mangrove_apple", 1),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:fruit_mangrove_apple"},
            },
        })

    end

end

function unilib.pkg.fruit_mangrove_apple.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_mangrove_apple",

        replace_mode = mode,
        leaves_list = {"unilib:tree_mangrove_apple_leaves"},
        pkg_list = {"tree_mangrove_apple"},
    })

end
