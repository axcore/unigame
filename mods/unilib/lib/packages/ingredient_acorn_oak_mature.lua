---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/oak
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_acorn_oak_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.oak.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_acorn_oak_mature.init()

    return {
        description = "Mature oak tree acorn",
        notes = "Grows on mature oak trees, and is edible",
    }

end

function unilib.pkg.ingredient_acorn_oak_mature.exec()

    unilib.register_node("unilib:ingredient_acorn_oak_mature", "oak:acorn", mode, {
        -- From oak:acorn
        description = S("Mature Oak Tree Acorn"),
        tiles = {"unilib_ingredient_acorn_oak_mature.png"},
        -- N.B. no food_acorn in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_acorn = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_acorn_oak_mature.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,

        after_place_node = function(pos, placer, itemstack)
            minetest.set_node(pos, {name = "unilib:ingredient_acorn_oak_mature", param2 = 1})
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:ingredient_acorn_oak_mature", 2),
    })

end

function unilib.pkg.ingredient_acorn_oak_mature.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:ingredient_acorn_oak_mature",

        replace_mode = mode,
        leaves_list = {"unilib:tree_oak_mature_leaves"},
        pkg_list = {"tree_oak_mature"},
    })

end
