---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pie_pumpkin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pie_pumpkin.init()

    return {
        description = "Pumpkin pie",
        depends = {
            "food_milk_soy_yellow",
            "ingredient_flour_ordinary",
            "ingredient_sugar_beet",
            "plant_pumpkin_red_wild",
        },
    }

end

function unilib.pkg.food_pie_pumpkin.exec()

    unilib.register_craftitem(
        -- From cropocalypse:uncooked_pumpkin_pie
        "unilib:food_pie_pumpkin_uncooked",
        "cropocalypse:uncooked_pumpkin_pie",
        mode,
        {
            description = S("Uncooked Pumpkin Pie"),
            inventory_image = "unilib_food_pie_pumpkin_uncooked.png",
            groups = {flammable = 1, food_uncooked_pumpkin_pie = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_pie_pumpkin_uncooked", 4),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:uncooked_pumpkin_pie
        type = "shapeless",
        output = "unilib:food_pie_pumpkin_uncooked",
        recipe = {
            "unilib:ingredient_flour_ordinary",
            "unilib:ingredient_sugar_beet",
            "unilib:ingredient_sugar_beet",
            "unilib:plant_pumpkin_red_wild_chunk",
            "unilib:plant_pumpkin_red_wild_chunk",
            "unilib:plant_pumpkin_red_wild_chunk",
            "unilib:food_milk_soy_yellow",
        },
    })

    unilib.register_craftitem("unilib:food_pie_pumpkin", "cropocalypse:cooked_pumpkin_pie", mode, {
        -- From cropocalypse:cooked_pumpkin_pie
        description = S("Pumpkin Pie"),
        inventory_image = "unilib_food_pie_pumpkin.png",
        groups = {flammable = 1, food_cooked_pumpkin_pie = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pie_pumpkin", 8),
    })
    unilib.register_craft({
        -- From cropocalypse:cooked_pumpkin_pie
        type = "cooking",
        output = "unilib:food_pie_pumpkin",
        recipe = "unilib:food_pie_pumpkin_uncooked",
    })

end
