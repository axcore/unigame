---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_orange.init()

    return {
        description = "Orange-flavoured ice cream",
        depends = {"food_cone_icecream", "fruit_orange", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_orange.exec()

    unilib.register_craftitem("unilib:food_icecream_orange", "icecream:orange", mode, {
        -- From icecream:orange
        description = S("Orange-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_orange.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_orange", 8),
    })
    unilib.register_craft({
        -- From icecream:orange
        output = "unilib:food_icecream_orange",
        recipe = {
            {"unilib:snow_ordinary"},
            {"unilib:fruit_orange"},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_orange",
        recipe = {
            {"unilib:fruit_orange", "unilib:fruit_orange", "unilib:fruit_orange"},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
