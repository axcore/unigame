---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chilli_bowl = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chilli_bowl.init()

    return {
        description = "Bowl of chilli",
        depends = "utensil_bowl_wooden",
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "produce_bean_green",               -- group:food_beans
            "produce_chilli_normal",            -- group:food_chilli_pepper
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_chilli_bowl.exec()

    unilib.register_craftitem("unilib:food_chilli_bowl", "farming:chili_bowl", mode, {
        -- From farming:chili_bowl
        description = S("Bowl of Chilli"),
        inventory_image = "unilib_food_chilli_bowl.png",
        -- N.B. No groups in original code
        groups = {food_bowl_chilli = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_chilli_bowl", 8, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:chili_bowl
        output = "unilib:food_chilli_bowl",
        recipe = {
            {"group:food_chilli_pepper", "group:food_rice", "group:food_tomato"},
            {"group:food_beans", "unilib:utensil_bowl_wooden", ""},
        },
    })

end
