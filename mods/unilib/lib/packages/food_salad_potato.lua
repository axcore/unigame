---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_salad_potato = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_salad_potato.init()

    return {
        description = "Potato and cucumber salad",
        depends = {"food_potato_baked", "utensil_bowl_wooden"},
        suggested = {
            "produce_cucumber_normal",          -- group:food_cucumber
        },
    }

end

function unilib.pkg.food_salad_potato.exec()

    unilib.register_craftitem("unilib:food_salad_potato", "farming:potato_salad", mode, {
        -- From farming:potato_salad
        description = S("Potato and Cucumber Salad"),
        inventory_image = "unilib_food_salad_potato.png",
        -- N.B. No groups in original code
        groups = {food_potato_salad = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_salad_potato", 10, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:potato_salad
        output = "unilib:food_salad_potato",
        recipe = {
            {"group:food_cucumber"},
            {"unilib:food_potato_baked"},
            {"unilib:utensil_bowl_wooden"},
        },
    })

end
