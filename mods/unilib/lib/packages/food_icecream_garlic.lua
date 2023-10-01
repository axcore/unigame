---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_garlic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_garlic.init()

    return {
        description = "Garlic-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_garlic_normal", "snow_ordinary"},
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_garlic.exec()

    local c_garlic = "unilib:produce_garlic_normal_clove"

    unilib.register_craftitem("unilib:food_icecream_garlic", "icecream:garlic", mode, {
        -- From icecream:garlic
        description = S("Garlic-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_garlic.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_garlic", 4),
    })
    unilib.register_craft({
        -- From icecream:garlic
        output = "unilib:food_icecream_garlic",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_garlic},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_garlic",
        recipe = {
            {c_garlic, c_garlic, c_garlic},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })

end
