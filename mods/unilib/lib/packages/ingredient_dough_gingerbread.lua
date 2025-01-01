---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_gingerbread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_gingerbread.init()

    return {
        description = "Gingerbread dough",
        depends = {
            "ingredient_flour_ordinary",
            "ingredient_sugar_cane",
            "produce_ginger",
            "vessel_bottle_glass_with_water",
        },
    }

end

function unilib.pkg.ingredient_dough_gingerbread.exec()

    unilib.register_craftitem(
        -- From better_farming:gingerdough
        "unilib:ingredient_dough_gingerbread",
        "better_farming:gingerdough",
        mode,
        {
            description = S("Gingerbread Dough"),
            inventory_image = "unilib_ingredient_dough_gingerbread.png",
            groups = {flammable = 2, food_cotton_candy = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:ingredient_dough_gingerbread", 1),
        }
    )
    unilib.register_craft({
        -- From better_farming:gingerdough
        output = "unilib:ingredient_dough_gingerbread 3",
        recipe = {
            {
                "unilib:vessel_bottle_glass_with_water",
                "unilib:ingredient_flour_ordinary",
                "unilib:produce_ginger_harvest",
            },
            {
                "unilib:ingredient_sugar_cane",
                "unilib:ingredient_sugar_cane",
                "",
            },
        },
    })
    -- N.B. Original recipe removed, because it makes the recipe above pointless
    --[[
    unilib.register_craft({
        -- From better_farming:gingerdough
        type = "cooking",
        output = "unilib:ingredient_dough_gingerbread",
        recipe = "unilib:produce_ginger_harvest",
    })
    ]]--

end
