---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pork_chop_stuffed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pork_chop_stuffed.init()

    return {
        description = "Stuffed pork chop",
        depends = {"food_bread_ordinary", "fruit_apple", "mushroom_brown"},
        suggested = {
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_pork_chop_stuffed.exec()

    unilib.register_craftitem("unilib:food_pork_chop_stuffed_raw", "bbq:stuffed_chop_raw", mode, {
        -- From bbq:stuffed_chop_raw
        description = S("Raw Stuffed Pork Chop"),
        inventory_image = "unilib_food_pork_chop_stuffed_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_pork_chop_stuffed_raw", 3),
    })
    unilib.register_craft({
        -- From bbq:stuffed_chop_raw
        type = "shapeless",
        output = "unilib:food_pork_chop_stuffed_raw 3",
        recipe = {
            "group:food_onion",
            "unilib:food_bread_ordinary",
            "unilib:mushroom_brown",
            "group:food_pork_raw",
            "unilib:fruit_apple",
        },
    })
    unilib.register_external_ingredient("unilib:food_pork_chop_stuffed_raw", {
        "group:food_pork_raw",                  -- Originally mobs:pork_raw
    })

    unilib.register_craftitem("unilib:food_pork_chop_stuffed", "bbq:stuffed_chop", mode, {
        -- From bbq:stuffed_chop
        description = S("Stuffed Pork Chop"),
        inventory_image = "unilib_food_pork_chop_stuffed.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_pork_chop_stuffed", 8),
    })
    unilib.register_craft({
        -- From bbq:stuffed_chop
        type = "cooking",
        output = "unilib:food_pork_chop_stuffed",
        recipe = "unilib:food_pork_chop_stuffed_raw",
        cooktime = 8,
    })

end
