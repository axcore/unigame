---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_vegan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_vegan.init()

    return {
        description = "Vegan ice cream",
        depends = {"ingredient_cream_coconut", "snow_ordinary", "vessel_glass_empty"},
        at_least_one = {"food_milk_coconut", "food_milk_soy", "food_milk_soy_red"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_icecream_vegan.exec()

    unilib.register_craftitem("unilib:food_icecream_vegan", "cheese:vegan_ice_cream_base", mode, {
        -- From cheese:vegan_ice_cream_base
        description = S("Vegan Ice Cream"),
        inventory_image = "unilib_food_icecream_vegan.png",
        groups = {food = 5, food_icecream = 1, food_icecream_base = 1, vegan_alternative = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_vegan", 3),
    })
    if unilib.global.pkg_executed_table["food_milk_soy"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "shapeless",
            output = "unilib:food_icecream_vegan 4",
            recipe = {
                "unilib:food_milk_soy",
                "unilib:ingredient_cream_coconut",
                "unilib:ingredient_cream_coconut",
                "group:food_sugar",
                "unilib:snow_ordinary",
            },
            replacements = {
                {"unilib:food_milk_soy", "unilib:vessel_glass_empty"},
            },
        })

    end
    if unilib.global.pkg_executed_table["food_milk_soy_red"] ~= nil then

        unilib.register_craft({
            -- From cheese:vegan_ice_cream_base
            type = "shapeless",
            output = "unilib:food_icecream_vegan 4",
            recipe = {
                "unilib:food_milk_soy_red",
                "unilib:ingredient_cream_coconut",
                "unilib:ingredient_cream_coconut",
                "group:food_sugar",
                "unilib:snow_ordinary",
            },
            replacements = {
                {"unilib:food_milk_soy_red", "unilib:vessel_glass_empty"},
            },
        })

    end
    if unilib.global.pkg_executed_table["food_milk_coconut"] ~= nil then

        unilib.register_craft({
            -- From cheese:vegan_ice_cream_base
            type = "shapeless",
            output = "unilib:food_icecream_vegan 4",
            recipe = {
                "unilib:food_milk_coconut",
                "unilib:food_milk_coconut",
                "unilib:ingredient_cream_coconut",
                "unilib:ingredient_cream_coconut",
                "group:food_sugar",
                "unilib:snow_ordinary",
            },
            replacements = {
                {"unilib:food_milk_coconut", "unilib:vessel_glass_empty"},
                {"unilib:food_milk_coconut", "unilib:vessel_glass_empty"},
            },
        })

    end

end
