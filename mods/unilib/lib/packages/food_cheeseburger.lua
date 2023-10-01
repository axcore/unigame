---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheeseburger = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheeseburger.init()

    return {
        description = "Cheeseburger",
        notes = "Renamed as a cheeseburger to distinguish it from the BBQ mod's hamburger",
        depends = "food_bread_ordinary",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "produce_cucumber_normal",          -- group:food_cucumber
            "produce_lettuce",                  -- group:food_lettuce
            "produce_onion_normal",             -- group:food_onion
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_cheeseburger.exec()

    unilib.register_craftitem("unilib:food_cheeseburger", "farming:burger", mode, {
        -- From farming:burger
        description = S("Cheeseburger"),
        inventory_image = "unilib_food_cheeseburger.png",
        -- N.B. No groups in original code
        groups = {food_burger = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheeseburger", 16),
    })
    unilib.register_craft({
        -- From farming:burger
        output = "unilib:food_cheeseburger",
        recipe = {
            {"unilib:food_bread_ordinary", "group:food_meat", "group:food_cheese"},
            {"group:food_tomato", "group:food_cucumber", "group:food_onion"},
            {"group:food_lettuce", "", ""},
        }
    })
    unilib.register_external_ingredient("unilib:food_cheeseburger", {
        "group:food_meat",                      -- Originally group:food_meat
    })

end
