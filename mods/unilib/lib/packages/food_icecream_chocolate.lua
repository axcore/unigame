---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_chocolate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_chocolate.init()

    return {
        description = "Chocolate-flavoured ice cream",
        depends = {"food_cone_icecream", "food_chocolate_dark", "snow_ordinary"},
        optional = "food_chocolate_biscuit",
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_chocolate.exec()

    local c_chocolate = "unilib:food_chocolate_dark_bar"

    unilib.register_craftitem("unilib:food_icecream_chocolate", "icecream:chocolate", mode, {
        -- From icecream:chocolate
        description = S("Chocolate-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_chocolate.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_chocolate", 8),
    })
    unilib.register_craft({
        -- From icecream:chocolate
        output = "unilib:food_icecream_chocolate",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_chocolate},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_chocolate",
        recipe = {
            {c_chocolate, c_chocolate, c_chocolate},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })
    if unilib.pkg_executed_table["food_chocolate_biscuit"] ~= nil then

        unilib.register_craftitem(
            -- From icecream:chocolate_with_cookies
            "unilib:food_icecream_chocolate_chip",
            "icecream:chocolate_with_cookies",
            mode,
            {
                description = S("Chocolate-Chip Ice Cream"),
                inventory_image = "unilib_food_icecream_chocolate_chip.png",
                groups = {food_icecream = 1},

                on_use = unilib.cuisine_eat_on_use("unilib:food_icecream_chocolate_chip", 12),
            }
        )
        unilib.register_craft({
            -- From icecream:chocolate_with_cookies
            output = "unilib:food_icecream_chocolate_chip",
            recipe = {
                {"unilib:food_chocolate_biscuit"},
                {"unilib:food_icecream_chocolate"},
            },
        })

    end

end
