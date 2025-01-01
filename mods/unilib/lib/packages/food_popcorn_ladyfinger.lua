---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_popcorn_ladyfinger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_popcorn_ladyfinger.init()

    return {
        description = "Ladyfinger popcorn",
        depends = "produce_corn_flint",
    }

end

function unilib.pkg.food_popcorn_ladyfinger.exec()

    unilib.register_craftitem("unilib:food_popcorn_ladyfinger", "better_farming:pop_corn", mode, {
        -- From better_farming:pop_corn
        description = S("Ladyfinger Popcorn"),
        inventory_image = "unilib_food_popcorn_ladyfinger.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_popcorn_ladyfinger", 1),
    })
    unilib.register_craft({
        -- From better_farming:pop_corn
        type = "cooking",
        output = "unilib:food_popcorn_ladyfinger 2",
        recipe = "unilib:produce_corn_flint_harvest",
    })

end
