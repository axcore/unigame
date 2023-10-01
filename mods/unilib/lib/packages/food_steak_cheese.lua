---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_steak_cheese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_steak_cheese.init()

    return {
        description = "Cheese steak",
        depends = {"food_beef_normal", "food_bread_ordinary"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_pepper",                      -- group:food_pepper
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_steak_cheese.exec()

    unilib.register_craftitem("unilib:food_steak_cheese", "bbq:cheese_steak", mode, {
        -- From bbq:cheese_steak
        description = S("Cheese Steak"),
        inventory_image = "unilib_food_steak_cheese.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_steak_cheese", 8),
    })
    unilib.register_craft({
        -- From bbq:cheese_steak
        type = "shapeless",
        output = "unilib:food_steak_cheese 2",
        recipe = {
            "unilib:food_bread_ordinary",
            "group:food_pepper",
            "unilib:food_beef_normal_cooked",
            "group:food_cheese",
            "group:food_onion",
        },
    })

end
