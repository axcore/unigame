---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_pineapple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_pineapple.init()

    return {
        description = "Pineapple-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_pineapple", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_pineapple.exec()

    local c_pineapple = "unilib:food_ring_pineapple"

    unilib.register_craftitem("unilib:food_icecream_pineapple", "icecream:pineapple", mode, {
        -- From icecream:pineapple
        description = S("Pineapple-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_pineapple.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_pineapple", 4),
    })
    unilib.register_craft({
        -- From icecream:pineapple
        output = "unilib:food_icecream_pineapple",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_pineapple},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_pineapple",
        recipe = {
            {c_pineapple, c_pineapple, c_pineapple},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
