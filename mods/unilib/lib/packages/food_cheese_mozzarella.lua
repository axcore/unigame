---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_mozzarella = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_mozzarella.init()

    return {
        description = "Mozzarella cheese",
        depends = "ingredient_cheese_stretched",
    }

end

function unilib.pkg.food_cheese_mozzarella.exec()

    local c_stretched = "unilib:ingredient_cheese_stretched"

    unilib.register_craftitem("unilib:food_cheese_mozzarella", "cheese:mozzarella", mode, {
        -- From cheese:mozzarella
        description = S("Mozzarella"),
        inventory_image = "unilib_food_cheese_mozzarella.png",
        groups = {food = 4, food_cheese = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_mozzarella", 4),
    })
    unilib.register_craft({
        -- From cheese:mozzarella
        output = "unilib:food_cheese_mozzarella 4",
        recipe = {
            {"", c_stretched, ""},
            {c_stretched, c_stretched, c_stretched},
            {"", c_stretched, ""},
        }
    })

end
