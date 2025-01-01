---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sandwich_worm = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sandwich_worm.init()

    return {
        description = "Worm sandwich",
        depends = {"food_bread_ordinary", "item_worm_juicy"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_sandwich_worm.exec()

    unilib.register_craftitem("unilib:food_sandwich_worm", nil, mode, {
        -- Original to unilib
        description = S("Worm Sandwich"),
        inventory_image = "unilib_food_sandwich_worm.png",
        groups = {food_sandwich = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_sandwich_worm", -2),
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_sandwich_worm",
        recipe = {
            {"unilib:item_worm_juicy"},
            {"group:food_cheese"},
            {"unilib:food_bread_ordinary"},
        },
    })

end

