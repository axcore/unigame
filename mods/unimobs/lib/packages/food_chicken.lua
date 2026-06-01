---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken.init()

    return {
        description = "Normal chicken meat",
    }

end

function unilib.pkg.food_chicken.exec()

    unilib.register_craftitem("unilib:food_chicken_raw", "petz:raw_chicken", mode, {
        -- From petz:raw_chicken
        description = S("Raw Normal Chicken"),
        inventory_image = "unilib_food_chicken_raw.png",
        -- N.B. food_chicken_raw = 1 not in original code
        groups = {flammable = 2, food = 2, food_chicken_raw = 1, food_meat_raw = 1},

        wield_image = "unilib_food_chicken_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_chicken_raw", 1),
    })

    unilib.register_craftitem("unilib:food_chicken_roasted", "petz:roasted_chicken", mode, {
        -- From petz:roasted_chicken
        description = S("Roasted Normal Chicken"),
        inventory_image = "unilib_food_chicken_roasted.png",
        -- N.B. food_chicken = 1 not in original code
        groups = {flammable = 2, food = 2, food_chicken = 1, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_chicken_roasted", 3),
    })
    unilib.register_craft({
        -- From petz:roasted_chicken
        type = "cooking",
        output = "unilib:food_chicken_roasted",
        recipe = "unilib:food_chicken_raw",
        cooktime = 2,
    })

end
