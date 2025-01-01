---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_garlic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_garlic.init()

    return {
        description = "Garlic bread",
        suggested = {
            "food_bread_toast",                 -- group:food_toast
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_bread_garlic.exec()

    unilib.register_craftitem("unilib:food_bread_garlic", "farming:garlic_bread", mode, {
        -- From farming:garlic_bread
        description = S("Garlic Bread"),
        inventory_image = "unilib_food_bread_garlic.png",
        -- N.B. no food_bread in original code
        groups = {flammable = 3, food_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_garlic", 2),
    })
    unilib.register_craft({
        -- From farming:garlic_bread
        output = "unilib:food_bread_garlic",
        recipe = {
            {"group:food_toast", "group:food_garlic_clove", "group:food_garlic_clove"},
        },
    })

end
