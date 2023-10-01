---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_toast = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_toast.init()

    return {
        description = "Toast",
        depends = "food_bread_sliced",
    }

end

function unilib.pkg.food_bread_toast.exec()

    unilib.register_craftitem("unilib:food_bread_toast", "farming:toast", mode, {
        -- From farming:toast
        description = S("Toast"),
        inventory_image = "unilib_food_bread_toast.png",
        groups = {flammable = 2, food_toast = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_toast", 1),
    })
    unilib.register_craft({
        -- From farming:toast
        type = "cooking",
        output = "unilib:food_bread_toast",
        recipe = "unilib:food_bread_sliced",
        cooktime = 3,
    })

    unilib.register_craftitem("unilib:food_bread_toast_sandwich", "farming:toast_sandwich", mode, {
        -- From farming:toast_sandwich
        description = S("Toast Sandwich"),
        inventory_image = "unilib_food_bread_toast_sandwich.png",
        -- N.B. no food_toast in original code
        groups = {flammable = 2, food_toast = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_toast_sandwich", 4),
    })

    unilib.register_craft({
        -- From farming:toast_sandwich
        output = "unilib:food_bread_toast_sandwich",
        recipe = {
            {"unilib:food_bread_sliced"},
            {"unilib:food_bread_toast"},
            {"unilib:food_bread_sliced"},
        },
    })

end
