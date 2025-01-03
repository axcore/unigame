---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_banana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_banana.init()

    return {
        description = "Banana",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_banana.exec()

    unilib.register_node("unilib:fruit_banana", "ethereal:banana", mode, {
        -- From ethereal:banana
        description = S("Banana"),
        tiles = {"unilib_fruit_banana.png"},
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_banana = 1, leafdecay = 1,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "torchlike",
        inventory_image = "unilib_fruit_banana.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        place_param2 = 1,
        selection_box = {
            type = "fixed",
            fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_banana.png",

        -- N.B. No standard .after_place_node for fruits, because of unsuitable texture

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_banana", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_banana"},
            },
        })

    end

    unilib.register_node("unilib:fruit_banana_bunch", "ethereal:banana_bunch", mode, {
        -- From ethereal:banana_bunch
        description = S("Banana Bunch"),
        tiles = {"unilib_fruit_banana_bunch.png"},
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, leafdecay = 1, leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "torchlike",
        inventory_image = "unilib_fruit_banana_bunch.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        place_param2 = 1,
        selection_box = {
            type = "fixed",
            fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_banana_bunch.png",

--      on_use = core.item_eat(6),
        on_use = unilib.cuisine.eat_on_use("unilib:fruit_banana", 6),
    })
    unilib.register_craft({
        -- From ethereal:banana_bunch
        output = "unilib:fruit_banana_bunch",
        recipe = {
            {"unilib:fruit_banana", "unilib:fruit_banana", "unilib:fruit_banana"},
        },
    })
    unilib.register_craft({
        -- From ethereal:banana_bunch
        output = "unilib:fruit_banana 3",
        recipe = {
            {"unilib:fruit_banana_bunch"},
        },
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_banana_bunch"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_banana",
        juice_description = S("Banana"),
        juice_type = "banana",
        rgb = "#eced9f",

        orig_flag = true,
    })
    unilib.juice.register_duplicate("banana", "unilib:fruit_banana_bunch")

end

function unilib.pkg.fruit_banana.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_banana",

        replace_mode = mode,
        leaves_list = {"unilib:tree_banana_leaves"},
        pkg_list = {"tree_banana"},
    })

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_banana_bunch",

        replace_mode = mode,
        leaves_list = {"unilib:tree_banana_leaves"},
        pkg_list = {"tree_banana"},
    })

end
