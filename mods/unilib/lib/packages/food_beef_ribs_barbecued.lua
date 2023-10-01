---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_ribs_barbecued = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_ribs_barbecued.init()

    return {
        description = "Barbecued beef ribs",
        depends = {"food_beef_normal", "ingredient_sauce_barbecue"},
        suggested = {
            "ingredient_pepper_ground",         -- group:food_pepper_ground
        },
    }

end

function unilib.pkg.food_beef_ribs_barbecued.exec()

    unilib.register_craftitem(
        -- From bbq:bbq_beef_ribs_raw
        "unilib:food_beef_ribs_barbecued_raw",
        "bbq:bbq_beef_ribs_raw",
        mode,
        {
            description = S("Raw Barbecued Beef Ribs"),
            inventory_image = "unilib_food_beef_ribs_barbecued_raw.png",

            on_use = unilib.cuisine_eat_on_use("unilib:food_beef_ribs_barbecued_raw", 4),
        }
    )
    unilib.register_craft({
        -- From bbq:bbq_beef_ribs_raw
        type = "shapeless",
        output = "unilib:food_beef_ribs_barbecued_raw 2",
        recipe = {
            "unilib:ingredient_sauce_barbecue",
            "unilib:food_beef_normal_raw",
            "group:food_pepper_ground",
        },
    })

    unilib.register_craftitem("unilib:food_beef_ribs_barbecued", "bbq:bbq_beef_ribs", mode, {
        -- From bbq:bbq_beef_ribs
        description = S("Barbecued Beef Ribs"),
        inventory_image = "unilib_food_beef_ribs_barbecued.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_beef_ribs_barbecued", 9),
    })
    unilib.register_craft({
        -- From bbq:bbq_beef_ribs
        type = "cooking",
        output = "unilib:food_beef_ribs_barbecued",
        recipe = "unilib:food_beef_ribs_barbecued_raw",
        cooktime = 15,
    })

end
