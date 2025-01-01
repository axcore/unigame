---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pepper_pickled = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pepper_pickled.init()

    return {
        description = "Pickled peppers",
        depends = "ingredient_brine",
        suggested = {
            "food_pepper",                      -- group:food_pepper
            "produce_pepper",                   -- group:food_peppercorn
        },
    }

end

function unilib.pkg.food_pepper_pickled.exec()

    unilib.register_node("unilib:food_pepper_pickled", "bbq:pickled_peppers", mode, {
        -- From bbq:pickled_peppers
        description = S("Pickled Peppers"),
        tiles = {"unilib_food_pepper_pickled.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_pepper_pickled.png",
        -- N.B. is_ground_content = false not in original code; added to match other food items
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_food_pepper_pickled.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pepper_pickled", 5),
    })
    unilib.register_craft({
        -- From bbq:pickled_peppers
        type = "shapeless",
        output = "unilib:food_pepper_pickled",
        recipe = {"group:food_peppercorn", "group:food_pepper", "unilib:ingredient_brine"},
    })

end
