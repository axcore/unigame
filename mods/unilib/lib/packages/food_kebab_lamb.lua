---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_kebab_lamb = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_kebab_lamb.init()

    return {
        description = "Lamb Kebab",
        depends = {"item_stick_ordinary", "mushroom_brown"},
        suggested = {
            "food_pepper",                      -- group:food_pepper
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_kebab_lamb.exec()

    unilib.register_craftitem("unilib:food_kebab_lamb_raw", "bbq:lamb_kebab_raw", mode, {
        -- From bbq:lamb_kebab_raw
        description = S("Raw Lamb Kebab"),
        inventory_image = "unilib_food_kebab_lamb_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_kebab_lamb_raw", 2),
    })
    unilib.register_craft({
        -- From bbq:lamb_kebab_raw
        type = "shapeless",
        output = "unilib:food_kebab_lamb_raw 4",
        recipe = {
            "group:food_pepper",
            "group:food_mutton_raw",
            "unilib:item_stick_ordinary",
            "unilib:mushroom_brown",
            "group:food_onion",
        },
    })
    unilib.register_external_ingredient("unilib:food_kebab_lamb_raw", {
        "group:food_mutton_raw",                -- Originally mobs:mutton_raw
    })

    unilib.register_craftitem("unilib:food_kebab_lamb", "bbq:lamb_kebab", mode, {
        -- From bbq:lamb_kebab_raw
        description = S("Lamb Kebab"),
        inventory_image = "unilib_food_kebab_lamb.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_kebab_lamb", 4),
    })
    unilib.register_craft({
        -- From bbq:lamb_kebab_raw
        type = "cooking",
        output = "unilib:food_kebab_lamb",
        recipe = "unilib:food_kebab_lamb_raw",
        cooktime = 10,
    })

end
