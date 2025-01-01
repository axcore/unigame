---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.food_nuts_macadamia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_nuts_macadamia.init()

    return {
        description = "Macadamia nuts",
    }

end

function unilib.pkg.food_nuts_macadamia.exec()

    unilib.register_node("unilib:food_nuts_macadamia", "australia:macadamia", mode, {
        -- From australia:macadamia
        description = S("Macadamia Nuts"),
        tiles = {"unilib_food_nuts_macadamia.png"},
        -- N.B. no food_macadamia_nuts in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_macadamia_nuts = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_food_nuts_macadamia.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.67,
        walkable = false,
        wield_image = "unilib_food_nuts_macadamia.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:food_nuts_macadamia", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:food_nuts_macadamia", 1),
    })

end

function unilib.pkg.food_nuts_macadamia.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:food_nuts_macadamia",

        replace_mode = mode,
        leaves_list = {"unilib:tree_macadamia_prickly_leaves"},
        pkg_list = {"tree_macadamia_prickly"},
    })

end
