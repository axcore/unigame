---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_tonic_fruit = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_tonic_fruit.init()

    return {
        description = "Fruit tonic",
        depends = {"ingredient_whey", "vessel_bottle_glass_empty"},
        suggested = {
            "fruit_apple",                      -- group:food_apple
            "fruit_orange",                     -- group:food_orange
            "produce_grape",                    -- group:food_grapes
        },
    }

end

function unilib.pkg.drink_tonic_fruit.exec()

    local c_bottle = "unilib:vessel_bottle_glass_empty"

    unilib.register_craftitem("unilib:drink_tonic_fruit", "cheese:fruit_tonic", mode, {
        -- From cheese:fruit_tonic
        description = S("Fruit Tonic"),
        inventory_image = "unilib_drink_tonic_fruit.png",
        groups = {food = 8, vessel = 1},

        on_use = unilib.cuisine.drink_on_use(
            "unilib:drink_tonic_fruit", 8, "unilib:vessel_bottle_glass_empty"
        )
    })
    unilib.register_craft({
        -- From cheese:fruit_tonic
        output = "unilib:drink_tonic_fruit",
        recipe = {
            {"group:food_grapes", "group:food_orange", "group:food_apple"},
            {"group:food_apple", "group:food_grapes", "group:food_orange"},
            {c_bottle, "unilib:ingredient_whey", c_bottle},
        },
    })

end
