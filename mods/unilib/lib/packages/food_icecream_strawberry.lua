---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_strawberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_strawberry.init()

    return {
        description = "Strawberry-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_strawberry_normal", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_strawberry.exec()

    local c_strawberry = "unilib:produce_strawberry_normal_harvest"

    unilib.register_craftitem("unilib:food_icecream_strawberry", "icecream:strawberry", mode, {
        -- From icecream:strawberry
        description = S("Strawberry-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_strawberry.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_strawberry", 10),
    })
    unilib.register_craft({
        -- From icecream:strawberry
        output = "unilib:food_icecream_strawberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_strawberry},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_strawberry",
        recipe = {
            {c_strawberry, c_strawberry, c_strawberry},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
