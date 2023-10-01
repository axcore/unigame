---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_mushroom_stuffed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_mushroom_stuffed.init()

    return {
        description = "Stuffed mushroom",
        depends = {"food_bread_ordinary", "mushroom_brown"},
    }

end

function unilib.pkg.food_mushroom_stuffed.exec()

    unilib.register_craftitem(
        -- From bbq:stuffed_mushroom_raw
        "unilib:food_mushroom_stuffed_raw",
        "bbq:stuffed_mushroom_raw",
        mode,
        {
            description = S("Raw Stuffed Mushroom"),
            inventory_image = "unilib_food_mushroom_stuffed_raw.png",

            on_use = unilib.cuisine_eat_on_use("unilib:food_mushroom_stuffed_raw", 5),
        }
    )
    unilib.register_craft({
        -- From bbq:stuffed_mushroom_raw
        type = "shapeless",
        output = "unilib:food_mushroom_stuffed_raw 2",
        recipe = {"group:food_tomato", "unilib:food_bread_ordinary", "unilib:mushroom_brown"}
    })

    unilib.register_craftitem("unilib:food_mushroom_stuffed", "bbq:stuffed_mushroom", mode, {
        -- From bbq:stuffed_mushroom
        description = S("Stuffed Mushroom"),
        inventory_image = "unilib_food_mushroom_stuffed.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_mushroom_stuffed", 9),
    })
    unilib.register_craft({
        -- From bbq:stuffed_mushroom
        type = "cooking",
        output = "unilib:food_mushroom_stuffed",
        recipe = "unilib:food_mushroom_stuffed_raw",
        cooktime = 6,
    })

end
