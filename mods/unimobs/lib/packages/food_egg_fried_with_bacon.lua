---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_egg_fried_with_bacon = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_egg_fried_with_bacon.init()

    return {
        description = "Fried egg and bacon",
        depends = "food_pork_chop",
        suggested = {
            "food_egg_fried",                   -- group:food_egg_fried
        },
    }

end

function unilib.pkg.food_egg_fried_with_bacon.exec()

    unilib.register_craftitem("unilib:food_egg_fried_with_bacon", "petz:fried_egg_bacon", mode, {
        -- From petz:fried_egg_bacon
        description = S("Fried Egg and Bacon"),
        inventory_image = "unilib_food_egg_fried_with_bacon.png",
        groups = {flammable = 2, food = 2},

        on_use = unilib.cuisine.eat_on_use("unilib:food_egg_fried_with_bacon", 6),
    })
    unilib.register_craft({
        -- From petz:fried_egg_bacon
        type = "shapeless",
        output = "unilib:food_egg_fried_with_bacon",
        recipe = {"group:food_egg_fried", "unilib:food_pork_chop_roasted"},
    })

end
