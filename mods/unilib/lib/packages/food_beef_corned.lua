---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_corned = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_corned.init()

    return {
        description = "Corned beef",
        depends = {"food_beef_normal", "ingredient_brine"},
        suggested = {
            "produce_pepper",                   -- group:food_peppercorn
        },
    }

end

function unilib.pkg.food_beef_corned.exec()

    unilib.register_craftitem("unilib:food_beef_corned_raw", "bbq:corned_beef_raw", mode, {
        -- From bbq:corned_beef_raw
        description = S("Raw Corned Beef"),
        inventory_image = "unilib_food_beef_corned_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_beef_corned_raw", 5),
    })
    unilib.register_craft({
        -- From bbq:corned_beef_raw
        type = "shapeless",
        output = "unilib:food_beef_corned_raw",
        recipe = {
            "group:food_peppercorn",
            "unilib:food_beef_normal_raw",
            "unilib:ingredient_brine",
        },
    })

    unilib.register_craftitem("unilib:food_beef_corned", "bbq:corned_beef", mode, {
        -- From bbq:corned_beef
        description = S("Corned Beef"),
        inventory_image = "unilib_food_beef_corned.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_beef_corned", 10),
    })
    unilib.register_craft({
        -- From bbq:corned_beef
        type = "cooking",
        output = "unilib:food_beef_corned",
        recipe = "unilib:food_beef_corned_raw",
        cooktime = 15,
    })

end
