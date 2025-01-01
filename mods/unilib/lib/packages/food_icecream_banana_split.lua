---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_icecream_banana_split = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_icecream_banana_split.init()

    return {
        description = "Banana split",
        depends = "food_icecream_neapolitan",
        suggested = {
            "fruit_banana",                     -- group:food_banana
            "ingredient_cream_milk",            -- group:food_cream
        },
    }

end

function unilib.pkg.food_icecream_banana_split.exec()

    unilib.register_craftitem("unilib:food_icecream_banana_split", "cheese:banana_split", mode, {
        -- From cheese:banana_split
        description = S("Banana Split"),
        inventory_image = "unilib_food_icecream_banana_split.png",
        groups = {food = 15, food_icecream = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_icecream_banana_split", 15),
    })
    unilib.register_craft({
        -- From cheese:banana_split
        output = "unilib:food_icecream_banana_split",
        recipe = {
            {"", "group:food_cream", ""},
            {"", "unilib:food_icecream_neapolitan", ""},
            {"", "group:food_banana", ""},
        },
    })

end
