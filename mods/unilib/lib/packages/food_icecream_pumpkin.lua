---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_pumpkin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_pumpkin.init()

    return {
        description = "Pumpkin-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_pumpkin_yellow", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_pumpkin.exec()

    local c_slice = "unilib:produce_pumpkin_yellow_slice"

    unilib.register_craftitem("unilib:food_icecream_pumpkin", "icecream:pumpkin", mode, {
        -- From icecream:pumpkin
        description = S("Pumpkin-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_pumpkin.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_pumpkin", 6),
    })
    unilib.register_craft({
        -- From icecream:pumpkin
        output = "unilib:food_icecream_pumpkin",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_slice},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_pumpkin",
        recipe = {
            {c_slice, c_slice, c_slice},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
