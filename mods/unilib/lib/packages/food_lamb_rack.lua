---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_lamb_rack = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_lamb_rack.init()

    return {
        description = "Rack of labm",
        optional = "ingredient_sauce_barbecue",
    }

end

function unilib.pkg.food_lamb_rack.exec()

    unilib.register_craftitem("unilib:food_lamb_rack_raw", "bbq:rack_lamb_raw", mode, {
        -- From bbq:rack_lamb_raw
        description = S("Raw Rack of Lamb"),
        inventory_image = "unilib_food_lamb_rack_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_lamb_rack_raw", 5),
    })
    unilib.register_craft({
        -- From bbq:rack_lamb_raw
        type = "shapeless",
        output = "unilib:food_lamb_rack_raw 2",
        recipe = {
            "unilib:ingredient_sauce_barbecue",
            "group:food_mutton_raw",
            "group:food_mutton_raw",
        },
    })
    unilib.register_external_ingredient("unilib:food_lamb_rack_raw", {
        "group:food_mutton_raw",                -- Originally mobs:mutton_raw
    })

    unilib.register_craftitem("unilib:food_lamb_rack", "bbq:rack_lamb", mode, {
        -- From bbq:rack_lamb
        description = S("Rack of Lamb"),
        inventory_image = "unilib_food_lamb_rack.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_lamb_rack", 10),
    })
    unilib.register_craft({
        -- From bbq:rack_lamb
        type = "cooking",
        output = "unilib:food_lamb_rack",
        recipe = "unilib:food_lamb_rack_raw",
        cooktime = 10,
    })

end
