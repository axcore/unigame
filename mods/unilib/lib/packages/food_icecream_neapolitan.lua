---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_neapolitan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_neapolitan.init()

    return {
        description = "Neapolitan ice cream",
        depends = {"ingredient_extract_vanilla", "vessel_bottle_glass_empty"},
        suggested = {
            "food_chocolate_dark",              -- group:food_chocolate
            "food_icecream",                    -- group:food_icecream_base
            "produce_strawberry_normal",        -- group:food_strawberry
        },
    }

end

function unilib.pkg.food_icecream_neapolitan.exec()

    local c_base = "group:food_icecream_base"
    local c_vanilla = "unilib:ingredient_extract_vanilla"

    unilib.register_craftitem(
        -- From cheese:neapolitan_ice_cream
        "unilib:food_icecream_neapolitan",
        "cheese:neapolitan_ice_cream",
        mode,
        {
            description = S("Neapolitan Ice Cream"),
            inventory_image = "unilib_food_icecream_neapolitan.png",
            groups = {food = 11, food_icecream = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_neapolitan", 11),
        }
    )
    unilib.register_craft({
        -- From cheese:neapolitan_ice_cream
        output = "unilib:food_icecream_neapolitan 3",
        recipe = {
            {"", "", "group:food_strawberry"},
            {c_vanilla, "group:food_chocolate", "group:food_strawberry"},
            {c_base, c_base, c_base},
        },
        replacements = {
            {c_vanilla, "unilib:vessel_bottle_glass_empty"},
        },
    })

end
