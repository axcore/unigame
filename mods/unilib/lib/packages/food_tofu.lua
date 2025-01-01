---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_tofu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_tofu.init()

    return {
        description = "Tofu",
        notes = "Can be used as a substitute ingredient for items requiring meat",
        depends = "utensil_tray_baking",
        suggested = {
            "produce_soy_normal",               -- group:food_soy
        },
    }

end

function unilib.pkg.food_tofu.exec()

    unilib.register_craftitem("unilib:food_tofu", "farming:tofu", mode, {
        -- From farming:tofu
        description = S("Tofu"),
        inventory_image = "unilib_food_tofu.png",
        groups = {flammable = 2, food_meat_raw = 1, food_tofu = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_tofu", 3),
    })
    unilib.register_craft({
        -- From farming:tofu
        output = "unilib:food_tofu",
        recipe = {
            {"unilib:utensil_tray_baking", "group:food_soy", "group:food_soy"},
            {"group:food_soy", "group:food_soy", "group:food_soy"},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

    unilib.register_craftitem("unilib:food_tofu_cooked", "farming:tofu_cooked", mode, {
        -- From farming:tofu_cooked
        description = S("Cooked Tofu"),
        inventory_image = "unilib_food_tofu_cooked.png",
        groups = {flammable = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_tofu_cooked", 6),
    })
    unilib.register_craft({
        -- From farming:tofu_cooked
        type = "cooking",
        output = "unilib:food_tofu_cooked",
        recipe = "unilib:food_tofu",
        cooktime = 5,
    })

end
