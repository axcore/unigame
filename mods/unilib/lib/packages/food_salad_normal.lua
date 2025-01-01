---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_salad_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_salad_normal.init()

    return {
        description = "Normal salad",
        depends = "utensil_bowl_wooden",
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
            "produce_cucumber_normal",          -- group:food_cucumber
            "produce_lettuce",                  -- group:food_lettuce
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_salad_normal.exec()

    unilib.register_craftitem("unilib:food_salad_normal", "farming:salad", mode, {
        -- From farming:salad
        description = S("Normal Salad"),
        inventory_image = "unilib_food_salad_normal.png",
        -- N.B. No groups in original code
        groups = {food_normal_salad = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_salad_normal", 8, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:salad
        type = "shapeless",
        output = "unilib:food_salad_normal",
        recipe = {
            "unilib:utensil_bowl_wooden",
            "group:food_tomato",
            "group:food_cucumber",
            "group:food_lettuce",
            "group:food_oil",
        },
    })

end
