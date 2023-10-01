---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_raspberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_raspberry.init()

    return {
        description = "Raspberry-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_raspberry", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_raspberry.exec()

    local c_raspberry = "unilib:produce_raspberry_harvest"

    unilib.register_craftitem("unilib:food_icecream_raspberry", "icecream:raspberry", mode, {
        -- From icecream:raspberry
        description = S("Raspberry-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_raspberry.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_raspberry", 8),
    })
    unilib.register_craft({
        -- From icecream:raspberry
        output = "unilib:food_icecream_raspberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_raspberry},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_raspberry",
        recipe = {
            {c_raspberry, c_raspberry, c_raspberry},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
