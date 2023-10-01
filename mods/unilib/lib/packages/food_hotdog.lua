---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_hotdog = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_hotdog.init()

    return {
        description = "Hot dog",
        depends = {"food_bread_ordinary", "misc_sawdust"},
    }

end

function unilib.pkg.food_hotdog.exec()

    unilib.register_craftitem("unilib:food_hotdog_raw", "bbq:hotdog_raw", mode, {
        -- From bbq:hotdog_raw
        description = S("Raw Hot Dog"),
        inventory_image = "unilib_food_hotdog_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_hotdog_raw", 3),
    })
    unilib.register_craft({
        -- From bbq:hotdog_raw
        type = "shapeless",
        output = "unilib:food_hotdog_raw",
        recipe = {"group:food_pork_raw", "group:food_chicken_raw", "unilib:misc_sawdust"},
    })
    unilib.register_external_ingredient("unilib:food_hotdog_raw", {
        "group:food_pork_raw",                  -- Originally mobs:pork_raw
        "group:food_chicken_raw",               -- Originally mobs:chicken_raw
    })

    unilib.register_craftitem("unilib:food_hotdog_cooked", "bbq:hotdog_cooked", mode, {
        -- From bbq:hotdog_cooked
        description = S("Cooked Hot Dog"),
        inventory_image = "unilib_food_hotdog_cooked.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_hotdog_cooked", 7),
    })
    unilib.register_craft({
        -- From bbq:hotdog_cooked
        type = "cooking",
        output = "unilib:food_hotdog_cooked",
        recipe = "unilib:food_hotdog_raw",
        cooktime = 5,
    })

    unilib.register_craftitem("unilib:food_hotdog", "bbq:hotdog", mode, {
        -- From bbq:hotdog
        description = S("Hot Dog"),
        inventory_image = "unilib_food_hotdog.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_hotdog", 8),
    })
    unilib.register_craft({
        -- From bbq:hotdog
        type = "shapeless",
        output = "unilib:food_hotdog 2",
        recipe = {"unilib:food_hotdog_cooked", "unilib:food_bread_ordinary"}
    })

end
