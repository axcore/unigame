---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sliced_apple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sliced_apple.init()

    return {
        description = "Sliced apple",
        depends = "fruit_apple",
    }

end

function unilib.pkg.food_sliced_apple.exec()

    unilib.register_craftitem("unilib:food_sliced_apple", "cropocalypse:sliced_apples", mode, {
        -- From cropocalypse:sliced_apples
        description = S("Sliced Apples"),
        inventory_image = "unilib_food_sliced_apple.png",
        groups = {flammable = 1, food_sliced_apples = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_sliced_apple", 2),
    })
    unilib.register_craft({
        -- From cropocalypse:sliced_apples
        type = "shapeless",
        output = "unilib:food_sliced_apple 4",
        recipe = {"unilib:fruit_apple", "unilib:fruit_apple", "unilib:fruit_apple"},
    })

end
