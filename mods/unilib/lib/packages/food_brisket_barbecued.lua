---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_brisket_barbecued = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_brisket_barbecued.init()

    return {
        description = "Barbecued brisket",
        depends = {"food_beef_normal", "ingredient_molasses", "ingredient_sauce_barbecue"},
        suggested = {
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_brisket_barbecued.exec()

    unilib.register_craftitem("unilib:food_brisket_barbecued_raw", "bbq:brisket_raw", mode, {
        -- From bbq:brisket_raw
        description = S("Raw Barbecued Brisket"),
        inventory_image = "unilib_food_brisket_barbecued_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_brisket_barbecued_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:brisket_raw
        type = "shapeless",
        output = "unilib:food_brisket_barbecued_raw 2",
        recipe = {
            "unilib:ingredient_sauce_barbecue",
            "unilib:ingredient_molasses",
            "unilib:food_beef_normal_raw",
            "group:food_garlic_clove",
        }
    })

    unilib.register_craftitem("unilib:food_brisket_barbecued", "bbq:brisket", mode, {
        -- From bbq:brisket
        description = S("Barbecued Brisket"),
        inventory_image = "unilib_food_brisket_barbecued.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_brisket_barbecued", 9),
    })
    unilib.register_craft({
        -- From bbq:brisket
        type = "cooking",
        output = "unilib:food_brisket_barbecued",
        recipe = "unilib:food_brisket_barbecued_raw",
        cooktime = 15,
    })

end
