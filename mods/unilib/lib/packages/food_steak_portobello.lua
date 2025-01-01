---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_steak_portobello = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_steak_portobello.init()

    return {
        description = "Portobello steak",
        depends = {"ingredient_sauce_steak", "mushroom_brown"},
        suggested = {
            "ingredient_pepper_ground",         -- group:food_pepper_ground
        },
    }

end

function unilib.pkg.food_steak_portobello.exec()

    unilib.register_craftitem(
        -- From bbq:portebello_steak_raw
        "unilib:food_steak_portobello_raw",
        "bbq:portebello_steak_raw",
        mode,
        {
            description = S("Raw Portebello Steak"),
            inventory_image = "unilib_food_steak_portobello_raw.png",

            on_use = unilib.cuisine.eat_on_use("unilib:food_steak_portobello_raw", 5),
        }
    )
    unilib.register_craft({
        -- From bbq:portebello_steak_raw
        type = "shapeless",
        output = "unilib:food_steak_portobello_raw",
        recipe = {
            "group:food_pepper_ground",
            "unilib:ingredient_sauce_steak",
            "unilib:mushroom_brown",
        },
    })

    unilib.register_craftitem("unilib:food_steak_portobello", "bbq:portebello_steak", mode, {
        -- From bbq:portebello_steak
        description = S("Portebello Steak"),
        inventory_image = "unilib_food_steak_portobello.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_steak_portobello", 9),
    })
    unilib.register_craft({
        -- From bbq:portebello_steak
        type = "cooking",
        output = "unilib:food_steak_portobello",
        recipe = "unilib:food_steak_portobello_raw",
        cooktime = 6,
    })

end
