---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_lamb_leg = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_lamb_leg.init()

    return {
        description = "Leg of lamb",
        suggested = {
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_lamb_leg.exec()

    unilib.register_craftitem("unilib:food_lamb_leg_raw", "bbq:leg_lamb_raw", mode, {
        -- From bbq:leg_lamb_raw
        description = S("Raw Leg of Lamb"),
        inventory_image = "unilib_food_lamb_leg_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_lamb_leg_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:leg_lamb_raw
        type = "shapeless",
        output = "unilib:food_lamb_leg_raw 2",
        recipe = {"group:food_garlic_clove", "group:food_mutton_raw", "group:food_mutton_raw"},
    })
    unilib.register_external_ingredient("unilib:food_lamb_leg_raw", {
        "group:food_mutton_raw",                -- Originally mobs:mutton_raw
    })

    unilib.register_craftitem("unilib:food_lamb_leg", "bbq:leg_lamb", mode, {
        -- From bbq:leg_lamb
        description = S("Leg of Lamb"),
        inventory_image = "unilib_food_lamb_leg.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_lamb_leg", 9),
    })
    unilib.register_craft({
        -- From bbq:leg_lamb
        type = "cooking",
        output = "unilib:food_lamb_leg",
        recipe = "unilib:food_lamb_leg_raw",
        cooktime = 10,
    })

end
