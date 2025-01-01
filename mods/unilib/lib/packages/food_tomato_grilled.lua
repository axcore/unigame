---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_tomato_grilled = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_tomato_grilled.init()

    return {
        description = "Grilled tomato",
        suggested = {
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_tomato_grilled.exec()

    unilib.register_craftitem("unilib:food_tomato_grilled", "bbq:grilled_tomato", mode, {
        -- From bbq:grilled_tomato
        description = S("Grilled Tomato"),
        inventory_image = "unilib_food_tomato_grilled.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_tomato_grilled", 5),
    })
    unilib.register_craft({
        -- From bbq:grilled_tomato
        type = "cooking",
        output = "unilib:food_tomato_grilled",
        recipe = "group:food_tomato",
        cooktime = 4,
    })

end
