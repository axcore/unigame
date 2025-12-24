---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_parrot = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_parrot.init()

    return {
        description = "Parrot meat",
    }

end

function unilib.pkg.food_parrot.exec()

    unilib.register_craftitem("unilib:food_parrot_raw", "petz:raw_parrot", mode, {
        -- From petz:raw_parrot
        description = S("Raw Parrot"),
        inventory_image = "unilib_food_parrot_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_parrot_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_parrot_raw", 1),
    })

    unilib.register_craftitem("unilib:food_parrot_roasted", "petz:roasted_parrot", mode, {
        -- From petz:roasted_parrot
        description = S("Roasted Parrot"),
        inventory_image = "unilib_food_parrot_roasted.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_parrot_roasted", 2),
    })
    unilib.register_craft({
        -- From petz:roasted_parrot
        type = "cooking",
        output = "unilib:food_parrot_roasted",
        recipe = "unilib:food_parrot_raw",
        cooktime = 2,
    })

end
