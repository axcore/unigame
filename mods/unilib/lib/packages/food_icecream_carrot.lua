---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_carrot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_carrot.init()

    return {
        description = "Carrot-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_carrot_normal", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_carrot.exec()

    local c_carrot = "unilib:produce_carrot_normal_harvest"

    unilib.register_craftitem("unilib:food_icecream_carrot", "icecream:carrot", mode, {
        -- From icecream:carrot
        description = S("Carrot-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_carrot.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_carrot", 6),
    })
    unilib.register_craft({
        -- From icecream:carrot
        output = "unilib:food_icecream_carrot",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_carrot},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_carrot",
        recipe = {
            {c_carrot, c_carrot, c_carrot},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
