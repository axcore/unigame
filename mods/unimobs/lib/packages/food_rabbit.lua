---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_rabbit = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_rabbit.init()

    return {
        description = "Rabbit meat",
    }

end

function unilib.pkg.food_rabbit.exec()

    unilib.register_craftitem("unilib:food_rabbit_raw", "petz:raw_rabbit", mode, {
        -- From petz:raw_rabbit
        description = S("Raw Rabbit Meat"),
        inventory_image = "unilib_food_rabbit_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_rabbit_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_rabbit_raw", 1),
    })

    unilib.register_craftitem("unilib:food_rabbit_roasted", "petz:roasted_rabbit", mode, {
        -- From petz:roasted_rabbit
        description = S("Roasted Rabbit Meat"),
        inventory_image = "unilib_food_rabbit_roasted.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_rabbit_roasted", 3),
    })
    unilib.register_craft({
        -- From petz:roasted_rabbit
        type = "cooking",
        output = "unilib:food_rabbit_roasted",
        recipe = "unilib:food_rabbit_raw",
        cooktime = 2,
    })

end
