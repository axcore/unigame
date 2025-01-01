---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_vanilla = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_vanilla.init()

    return {
        description = "Vanilla-flavoured ice cream",
        depends = {"food_cone_icecream", "produce_vanilla", "snow_ordinary"},
        optional = "food_chocolate_biscuit",
        suggested = {
            "food_icecream",                    -- group:food_icecream_base
        },
    }

end

function unilib.pkg.food_icecream_vanilla.exec()

    local c_vanilla = "unilib:produce_vanilla_harvest"

    unilib.register_craftitem("unilib:food_icecream_vanilla", "icecream:vanilla", mode, {
        -- From icecream:vanilla
        description = S("Vanilla-Flavoured Ice Cream"),
        inventory_image = "unilib_food_icecream_vanilla.png",
        groups = {food_icecream = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_vanilla", 10),
    })
    unilib.register_craft({
        -- From icecream:vanilla
        output = "unilib:food_icecream_vanilla",
        recipe = {
            {"unilib:snow_ordinary"},
            {c_vanilla},
            {"unilib:food_cone_icecream"},
        },
    })
    unilib.register_craft({
        -- Adapted from code in the "cheese" mod (in addition to, rather than replacing, the
        --      original craft recipe)
        output = "unilib:food_icecream_vanilla",
        recipe = {
            {c_vanilla, c_vanilla, c_vanilla},
            {"", "group:food_icecream_base", ""},
            {"", "unilib:food_cone_icecream", ""},
        },
    })
    if unilib.global.pkg_executed_table["food_chocolate_biscuit"] ~= nil then

        unilib.register_craftitem(
            -- From icecream:vanilla_with_cookies
            "unilib:food_icecream_vanilla_chip",
            "icecream:vanilla_with_cookies",
            mode,
            {
                description = S("Vanilla-Chip Ice Cream"),
                inventory_image = "unilib_food_icecream_vanilla_chip.png",
                groups = {food_icecream = 1},

                on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_vanilla_chip", 12),
            }
        )
        unilib.register_craft({
            -- From icecream:vanilla_with_cookies
            output = "unilib:food_icecream_vanilla_chip",
            recipe = {
                {"unilib:food_chocolate_biscuit"},
                {"unilib:food_icecream_vanilla"},
            },
        })

    end

end
