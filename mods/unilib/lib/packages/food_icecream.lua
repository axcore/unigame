---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream.init()

    return {
        description = "Ice cream",
        depends = {"bucket_steel", "ingredient_cream_milk", "snow_ordinary"},
        optional = "bucket_wood",
        suggested = {
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_icecream.exec()

    unilib.register_craftitem("unilib:food_icecream", "cheese:ice_cream_base", mode, {
        -- From cheese:ice_cream_base
        description = S("Ice Cream"),
        inventory_image = "unilib_food_icecream.png",
        groups = {food = 5, food_icecream = 1, food_icecream_base = 1, milk_product = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_icecream", 3),
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:food_icecream 4",
        recipe = {
            "group:food_milk",
            "unilib:ingredient_cream_milk",
            "unilib:ingredient_cream_milk",
            "group:food_sugar",
            "unilib:snow_ordinary",
        },
        replacements = {
            -- (From animalia mod)
            {"animalia:bucket_milk", "unilib:bucket_steel_empty"},
            -- (From mobs_animal mod)
            {"mobs:bucket_milk", "unilib:bucket_steel_empty"},
            {"mobs:wooden_bucket_milk", "unilib:bucket_wood_empty"},
            -- (From petz/petz mod)
            {"petz:bucket_milk", "unilib:bucket_steel_empty"},
        },
    })

end
