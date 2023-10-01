---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_steak_pepper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_steak_pepper.init()

    return {
        description = "Pepper steak",
        depends = "food_beef_normal",
        suggested = {
            "ingredient_pepper_ground",         -- group:food_pepper_ground
        },
    }

end

function unilib.pkg.food_steak_pepper.exec()

    unilib.register_craftitem("unilib:food_steak_pepper_raw", "bbq:pepper_steak_raw", mode, {
        -- From bbq:pepper_steak_raw
        description = S("Raw Pepper Steak"),
        inventory_image = "unilib_food_steak_pepper_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_steak_pepper_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:pepper_steak_raw
        type = "shapeless",
        output = "unilib:food_steak_pepper_raw",
        recipe = {
            "group:food_pepper_ground",
            "unilib:food_beef_normal_raw",
            "group:food_pepper_ground",
        },
    })

    unilib.register_craftitem("unilib:food_steak_pepper", "bbq:pepper_steak", mode, {
        -- From bbq:pepper_steak
        description = S("Pepper Steak"),
        inventory_image = "unilib_food_steak_pepper.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_steak_pepper", 10),
    })
    unilib.register_craft({
        -- From bbq:pepper_steak
        type = "cooking",
        output = "unilib:food_steak_pepper",
        recipe = "unilib:food_steak_pepper_raw",
        cooktime = 6,
    })

end
