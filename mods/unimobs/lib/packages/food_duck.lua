---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_duck = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_duck.init()

    return {
        description = "Duck meat",
    }

end

function unilib.pkg.food_duck.exec()

    unilib.register_craftitem("unilib:food_duck_raw", "petz:raw_ducky", mode, {
        -- From petz:raw_ducky
        description = S("Raw Duck"),
        inventory_image = "unilib_food_duck_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_duck_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_duck_raw", 1),
    })

    unilib.register_craftitem("unilib:food_duck_roasted", "petz:roasted_ducky", mode, {
        -- From petz:roasted_ducky
        description = S("Roasted Duck"),
        inventory_image = "unilib_food_duck_roasted.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_duck_roasted", 3),
    })
    unilib.register_craft({
        -- From petz:roasted_ducky
        type = "cooking",
        output = "unilib:food_duck_roasted",
        recipe = "unilib:food_duck_raw",
        cooktime = 2,
    })

end
