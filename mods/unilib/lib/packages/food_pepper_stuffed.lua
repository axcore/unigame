---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pepper_stuffed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pepper_stuffed.init()

    return {
        description = "Stuffed pepper",
        depends = "food_bread_ordinary",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_pepper",                      -- group:food_pepper
        },
    }

end

function unilib.pkg.food_pepper_stuffed.exec()

    unilib.register_craftitem("unilib:food_pepper_stuffed_raw", "bbq:stuffed_pepper_raw", mode, {
        -- From bbq:stuffed_pepper_raw
        description = S("Raw Stuffed Pepper"),
        inventory_image = "unilib_food_pepper_stuffed_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pepper_stuffed_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:stuffed_pepper_raw
        type = "shapeless",
        output = "unilib:food_pepper_stuffed_raw 3",
        recipe = {"group:food_cheese", "unilib:food_bread_ordinary", "group:food_pepper"},
    })

    unilib.register_craftitem("unilib:food_pepper_stuffed", "bbq:stuffed_pepper", mode, {
        -- From bbq:stuffed_pepper
        description = S("Stuffed Pepper"),
        inventory_image = "unilib_food_pepper_stuffed.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pepper_stuffed", 9),
    })
    unilib.register_craft({
        -- From bbq:stuffed_pepper
        type = "cooking",
        output = "unilib:food_pepper_stuffed",
        recipe = "unilib:food_pepper_stuffed_raw",
        cooktime = 4,
    })

end
