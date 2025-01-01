---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_watermelon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_watermelon.init()

    return {
        description = "Watermelon-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_melon", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_watermelon.exec()

    local c_slice = "unilib:produce_melon_slice"

    unilib.register_craftitem("unilib:food_icecream_watermelon", "icecream:watermelon", mode, {
        -- From icecream:watermelon
        description = S("Watermelon-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_watermelon.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_watermelon", 6),
    })
    unilib.register_craft({
        -- From icecream:watermelon
        output = "unilib:food_icecream_watermelon",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_slice},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_watermelon",
        recipe = {
            {c_slice, c_slice, c_slice},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
