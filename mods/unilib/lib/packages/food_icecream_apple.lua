---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_apple.init()

    return {
        description = "Apple-flavoured ice cream",
        depends = {"food_cone_icecream", "fruit_apple", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_apple.exec()

    unilib.register_craftitem("unilib:food_icecream_apple", "icecream:apple", mode, {
        -- From icecream:apple
        description = S("Apple-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_apple.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_apple", 8),
    })
    unilib.register_craft({
        -- From icecream:apple
        output = "unilib:food_icecream_apple",
        recipe = {
            {"unilib:snow_ordinary"},
            {"unilib:fruit_apple"},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_apple",
        recipe = {
            {"unilib:fruit_apple", "unilib:fruit_apple", "unilib:fruit_apple"},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
