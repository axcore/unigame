---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_grape = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_grape.init()

    return {
        description = "Grape-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_grape", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_grape.exec()

    local c_grape = "unilib:produce_grape_harvest"

    unilib.register_craftitem("unilib:food_icecream_grape", "icecream:grapes", mode, {
        -- From icecream:grapes
        description = S("Grape-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_grape.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_grape", 8),
    })
    unilib.register_craft({
        -- From icecream:grapes
        output = "unilib:food_icecream_grape",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_grape},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_grape",
        recipe = {
            {c_grape, c_grape, c_grape},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
