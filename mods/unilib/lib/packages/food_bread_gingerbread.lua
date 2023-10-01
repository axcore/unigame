---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_gingerbread = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_gingerbread.init()

    return {
        description = "Gingerbread",
        depends = "ingredient_dough_gingerbread",
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_bread_gingerbread.exec()

    local c_dough = "unilib:ingredient_dough_gingerbread"

    unilib.register_craftitem("unilib:food_bread_gingerbread", "better_farming:gingerbread", mode, {
        -- From better_farming:gingerbread
        description = S("Gingerbread"),
        inventory_image = "unilib_food_bread_gingerbread.png",
        groups = {flammable = 2, food_cotton_candy = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_gingerbread", 2),
    })
    unilib.register_craft({
        -- From better_farming:gingerbread
        type = "cooking",
        output = "unilib:food_bread_gingerbread",
        recipe = c_dough,
    })

    unilib.register_craftitem(
        -- From better_farming:gingerbread_man
        "unilib:food_bread_gingerbread_man",
        "better_farming:gingerbread_man",
        mode,
        {
            description = S("Gingerbread Man"),
            inventory_image = "unilib_food_bread_gingerbread_man.png",
            groups = {flammable = 2, food_cotton_candy = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_bread_gingerbread_man", 1),
        }
    )
    unilib.register_craft({
        -- From better_farming:gingerbread_man
        output = "unilib:food_bread_gingerbread_man",
        recipe = {
            {"", c_dough, ""},
            {c_dough, c_dough, c_dough},
            {c_dough, "", c_dough},
        }
    })

    unilib.register_craftitem("unilib:food_bread_gingerbread_woman", nil, mode, {
        -- Original to unilib
        description = S("Gingerbread Woman"),
        inventory_image = "unilib_food_bread_gingerbread_woman.png",
        groups = {flammable = 2, food_cotton_candy = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_gingerbread_woman", 1),
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_bread_gingerbread_woman",
        recipe = {
            {"", c_dough, ""},
            {c_dough, "group:food_sugar", c_dough},
            {c_dough, "", c_dough},
        }
    })

end
