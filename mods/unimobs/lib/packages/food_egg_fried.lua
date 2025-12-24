---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_egg_fried = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_egg_fried.init()

    return {
        description = "Fried egg",
        suggested = {
            "egg_chicken_normal",               -- group:food_egg
        },
    }

end

function unilib.pkg.food_egg_fried.exec()

    unilib.register_craftitem("unilib:food_egg_fried", "petz:fried_egg", mode, {
        -- From petz:fried_egg
        description = S("Fried Egg"),
        inventory_image = "unilib_food_egg_fried.png",
        groups = {flammable = 2, food = 2, food_egg_fried = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_egg_fried", 4),
    })
    unilib.register_craft({
        -- From petz:fried_egg
        type = "cooking",
        output = "unilib:food_egg_fried",
        recipe = "group:food_egg",
        cooktime = 2,
    })

end
