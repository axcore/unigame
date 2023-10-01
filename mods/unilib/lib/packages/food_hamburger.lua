---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_hamburger = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_hamburger.init()

    return {
        description = "Hamburger",
        depends = {"food_beef_normal", "food_bread_ordinary"},
    }

end

function unilib.pkg.food_hamburger.exec()

    unilib.register_craftitem("unilib:food_hamburger_patty_raw", "bbq:hamburger_patty_raw", mode, {
        -- From bbq:hamburger_patty_raw
        description = S("Raw Hamburger Patty"),
        inventory_image = "unilib_food_hamburger_patty_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_hamburger_patty_raw", 3),
    })
    unilib.register_craft({
        -- From bbq:hamburger_patty_raw
        type = "shapeless",
        output = "unilib:food_hamburger_patty_raw",
        recipe = {"unilib:food_beef_normal_raw"},
    })

    unilib.register_craftitem("unilib:food_hamburger_patty", "bbq:hamburger_patty", mode, {
        -- From bbq:hamburger_patty
        description = S("Hamburger Patty"),
        inventory_image = "unilib_food_hamburger_patty.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_hamburger_patty", 8),
    })
    unilib.register_craft({
        -- From bbq:hamburger_patty
        type = "cooking",
        output = "unilib:food_hamburger_patty",
        recipe = "unilib:food_hamburger_patty_raw",
        cooktime = 5,
    })

    unilib.register_craftitem("unilib:food_hamburger", "bbq:hamburger", mode, {
        -- From bbq:hamburger
        description = S("Hamburger"),
        inventory_image = "unilib_food_hamburger.png",
        -- N.B. No groups in original code
        groups = {food_burger = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_hamburger", 9),
    })
    unilib.register_craft({
        -- From bbq:hamburger
        type = "shapeless",
        output = "unilib:food_hamburger 2",
        recipe = {"unilib:food_bread_ordinary", "unilib:food_hamburger_patty"},
    })

end
