---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_muffin_blueberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_muffin_blueberry.init()

    return {
        description = "Blueberry muffin",
        suggested = {
            "food_bread_ordinary",              -- group:food_bread
            "fruit_blueberry_ordinary",         -- group:food_blueberries
        },
    }

end

function unilib.pkg.food_muffin_blueberry.exec()

    unilib.register_craftitem("unilib:food_muffin_blueberry", "farming:muffin_blueberry", mode, {
        -- From farming:muffin_blueberry
        description = S("Blueberry Muffin"),
        inventory_image = "unilib_food_muffin_blueberry.png",
        -- N.B. No groups in original code
        groups = {food_blueberry_muffin = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_muffin_blueberry", 2),
    })
    unilib.register_craft({
        -- From farming:muffin_blueberry
        output = "unilib:food_muffin_blueberry 2",
        recipe = {
            {"group:food_blueberries", "group:food_bread", "group:food_blueberries"},
        },
    })

end
