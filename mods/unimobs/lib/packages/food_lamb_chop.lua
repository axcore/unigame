---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_lamb_chop = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_lamb_chop.init()

    return {
        description = "Lamb chop",
    }

end

function unilib.pkg.food_lamb_chop.exec()

    unilib.register_craftitem("unilib:food_lamb_chop_raw", "petz:mini_lamb_chop", mode, {
        -- From petz:mini_lamb_chop
        description = S("Raw Lamb Chop"),
        inventory_image = "unilib_food_lamb_chop_raw.png",
        -- N.B. food_mutton_raw = 1 not in original code
        groups = {flammable = 2, food = 2, food_meat_raw = 1, food_mutton_raw = 1},

        wield_image = "unilib_food_lamb_chop_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_lamb_chop_raw", 1),
    })

    unilib.register_craftitem("unilib:food_lamb_chop_roasted", "petz:roasted_lamb_chop", mode, {
        -- From petz:roasted_lamb_chop
        description = S("Roasted Lamb Chop"),
        inventory_image = "unilib_food_lamb_chop_roasted.png",
        -- N.B. food_mutton = 1 not in original code
        groups = {flammable = 2, food = 2, food_meat = 1, food_mutton = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_lamb_chop_roasted", 3),
    })
    unilib.register_craft({
        -- From petz:roasted_lamb_chop
        type = "cooking",
        output = "unilib:food_lamb_chop_roasted",
        recipe = "unilib:food_lamb_chop_raw",
        cooktime = 3,
    })

end
