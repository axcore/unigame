---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_goat = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_goat.init()

    return {
        description = "Goat meat",
    }

end

function unilib.pkg.food_goat.exec()

    unilib.register_craftitem("unilib:food_goat_raw", "petz:raw_goat", mode, {
        -- From petz:raw_goat
        description = S("Raw Goat Meat"),
        inventory_image = "unilib_food_goat_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_goat_raw", 1),
    })

    unilib.register_craftitem("unilib:food_goat_roasted", "petz:roasted_goat_meat", mode, {
        -- From petz:roasted_goat_meat
        description = S("Roasted Goat Meat"),
        inventory_image = "unilib_food_goat_roasted.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_goat_roasted", 4),
    })
    unilib.register_craft({
        -- From petz:roasted_goat_meat
        type = "cooking",
        output = "unilib:food_goat_roasted",
        recipe = "unilib:food_goat_raw",
        cooktime = 3,
    })

end
