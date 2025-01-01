---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo (20241118 update)
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_mac_and_cheese = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_mac_and_cheese.init()

    return {
        description = "Mac and cheese",
        depends = "utensil_bowl_wooden",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_pasta",                       -- group:food_pasta
        },
    }

end

function unilib.pkg.food_mac_and_cheese.exec()

    unilib.register_craftitem("unilib:food_mac_and_cheese", "farming:mac_and_cheese", mode, {
        -- From farming:mac_and_cheese
        description = S("Mac and Cheese"),
        inventory_image = "unilib_food_mac_and_cheese.png",
        -- N.B. food_mac_and_cheese = 1 not in original code
        groups = {flammable = 2, food_mac_and_cheese = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_mac_and_cheese", 6, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:mac_and_cheese
        output = "unilib:food_mac_and_cheese",
        -- N.B. group:food_bowl in the original recipe
        recipe = {
            {"group:food_pasta", "group:food_cheese", "unilib:utensil_bowl_wooden"},
        },
    })

end
