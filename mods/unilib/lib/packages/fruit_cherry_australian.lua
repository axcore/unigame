---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_cherry_australian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_cherry_australian.init()

    return {
        description = "Bunch of Australian cherries",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_cherry_australian.exec()

    unilib.register_node("unilib:fruit_cherry_australian", "australia:cherry", mode, {
        -- From australia:cherry
        description = S("Bunch of Australian Cherries"),
        tiles = {"unilib_fruit_cherry_australian.png"},
        -- N.B. no food_cherry in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_cherry = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_cherry_australian.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.67,
        walkable = false,
        wield_image = "unilib_fruit_cherry_australian.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_cherry_australian", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_cherry_australian", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_cherry_australian"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_cherry_australian",
        juice_description = S("Cherry"),
        juice_type = "cherry",
        rgb = "#9c0024",

        orig_flag = false,
    })

end

function unilib.pkg.fruit_cherry_australian.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_cherry_australian",

        replace_mode = mode,
        leaves_list = {"unilib:tree_cherry_australian_leaves"},
        pkg_list = {"tree_cherry_australian"},
    })

end
