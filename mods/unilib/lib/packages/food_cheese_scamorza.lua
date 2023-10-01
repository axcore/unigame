---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_scamorza = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_scamorza.init()

    return {
        description = "Scamorza cheese",
        depends = "ingredient_cheese_stretched",
    }

end

function unilib.pkg.food_cheese_scamorza.exec()

    local c_stretched = "unilib:ingredient_cheese_stretched"

    unilib.register_craftitem("unilib:food_cheese_scamorza", "cheese:scamorza", mode, {
        -- From cheese:scamorza
        description = S("Scamorza"),
        inventory_image = "unilib_food_cheese_scamorza.png",
        groups = {food = 4, food_cheese = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_scamorza", 4),
    })
    unilib.register_craft({
        -- From cheese:scamorza
        output = "unilib:food_cheese_scamorza 4",
        recipe = {
            {"", c_stretched, ""},
            {c_stretched, c_stretched, ""},
            {c_stretched, c_stretched, ""},
        }
    })

    unilib.register_craftitem(
        -- From cheese:smoked_scamorza
        "unilib:food_cheese_scamorza_smoked",
        "cheese:smoked_scamorza",
        mode,
        {
            description = S("Smoked Scamorza"),
            inventory_image = "unilib_food_cheese_scamorza_smoked.png",
            groups = {food = 7, food_cheese = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_scamorza_smoked", 7),
        }
    )
    unilib.register_craft({
        -- From cheese:smoked_scamorza
        type = "cooking",
        output = "unilib:food_cheese_scamorza_smoked",
        recipe = "unilib:food_cheese_scamorza",
        cooktime = 11,
    })

end
