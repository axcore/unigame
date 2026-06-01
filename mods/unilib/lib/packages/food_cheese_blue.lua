---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bluecheese
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bluecheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_blue.init()

    return {
        description = "Blue cheese",
        depends = "plant_mould_underground",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_cheese_blue.exec()

    unilib.register_craftitem("unilib:food_cheese_blue", "bluecheese:cheese", mode, {
        -- From bluecheese:cheese
        description = S("Blue Cheese"),
        inventory_image = "unilib_food_cheese_blue.png",
        -- N.B. No groups in original code
        groups = {food = 2, food_cheese = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cheese_blue", 5),
    })
    unilib.register_craft({
        -- From bluecheese:cheese
        type = "shapeless",
        output = "unilib:food_cheese_blue",
        -- N.B. "mobs:cheese" in the original code
        recipe = {"group:food_cheese", "unilib:plant_mould_underground"},
    })

end
