---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_banana = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

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
        sounds = unilib.sound_table.leaves,

        drawtype = "torchlike",
        drop = "unilib:fruit_banana",
        inventory_image = "unilib_fruit_banana.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_banana.png",

        after_place_node = function(pos, placer)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_banana", param2 = 1})
            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_banana", 2),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

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
        -- N.B. no food_banana in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_banana = 1, leafdecay = 1,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "torchlike",
        drop = "unilib:fruit_banana_bunch",
        inventory_image = "unilib_fruit_banana_bunch.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_banana_bunch.png",

        after_place_node = function(pos, placer)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_banana_bunch", param2 = 1})
            end

        end,

--      on_use = minetest.item_eat(6),
        on_use = unilib.cuisine_eat_on_use("unilib:fruit_banana", 6),
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
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

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
    unilib.register_juice_duplicate("banana", "unilib:fruit_banana_bunch")

end

function unilib.pkg.fruit_banana.post()

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_banana",

        replace_mode = mode,
        leaves_list = {"unilib:tree_banana_leaves"},
        pkg_list = {"tree_banana"},
    })

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_banana_bunch",

        replace_mode = mode,
        leaves_list = {"unilib:tree_banana_leaves"},
        pkg_list = {"tree_banana"},
    })

end
