---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sandwich_cheese_cucumber = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sandwich_cheese_cucumber.init()

    return {
        description = "Cheese and cucumber sandwich",
        depends = {"food_bread_ordinary", "produce_cucumber_normal"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_sandwich_cheese_cucumber.exec()

    unilib.register_craftitem("unilib:food_sandwich_cheese_cucumber", nil, mode, {
        -- Original to unilib
        description = S("Cheese and Cucumber Sandwich"),
        inventory_image = "unilib_food_sandwich_cheese_cucumber.png",
        groups = {food_sandwich = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_sandwich_cheese_cucumber", 7),
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_sandwich_cheese_cucumber",
        recipe = {
            {"unilib:produce_cucumber_normal_harvest"},
            {"group:food_cheese"},
            {"unilib:food_bread_ordinary"},
        },
    })

end

