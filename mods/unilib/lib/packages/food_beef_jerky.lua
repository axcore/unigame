---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_jerky = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_jerky.init()

    return {
        description = "Beef jerky",
        depends = {"food_beef_normal", "ingredient_brine", "ingredient_liquid_smoke"},
    }

end

function unilib.pkg.food_beef_jerky.exec()

    unilib.register_craftitem("unilib:food_beef_jerky_raw", "bbq:beef_jerky_raw", mode, {
        -- From bbq:beef_jerky_raw
        description = S("Raw Beef Jerky"),
        inventory_image = "unilib_food_beef_jerky_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_beef_jerky_raw", 2),
    })
    unilib.register_craft({
        -- From bbq:beef_jerky_raw
        type = "shapeless",
        output = "unilib:food_beef_jerky_raw 3",
        recipe = {
            "unilib:ingredient_liquid_smoke",
            "unilib:ingredient_brine",
            "unilib:food_beef_normal_raw",
        },
    })

    unilib.register_craftitem("unilib:food_beef_jerky", "bbq:beef_jerky", mode, {
        -- From bbq:beef_jerky
        description = S("Beef Jerky"),
        inventory_image = "unilib_food_beef_jerky.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_beef_jerky", 5),
    })
    unilib.register_craft({
        -- From bbq:beef_jerky
        type = "cooking",
        output = "unilib:food_beef_jerky",
        recipe = "unilib:food_beef_jerky_raw",
        cooktime = 12,
    })

end
