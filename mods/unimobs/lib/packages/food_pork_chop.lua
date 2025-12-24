---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pork_chop = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pork_chop.init()

    return {
        description = "Pork chop",
    }

end

function unilib.pkg.food_pork_chop.exec()

    unilib.register_craftitem("unilib:food_pork_chop_raw", "petz:raw_porkchop", mode, {
        -- From petz:raw_porkchop
        description = S("Raw Pork Chop"),
        inventory_image = "unilib_food_pork_chop_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_pork_chop_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pork_chop_raw", 1),
    })

    unilib.register_craftitem("unilib:food_pork_chop_roasted", "petz:roasted_porkchop", mode, {
        -- From petz:roasted_porkchop
        description = S("Roasted Pork Chop"),
        inventory_image = "unilib_food_pork_chop_roasted.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pork_chop_roasted", 3),
    })
    unilib.register_craft({
        -- From petz:roasted_porkchop
        type = "cooking",
        output = "unilib:food_pork_chop_roasted",
        recipe = "unilib:food_pork_chop_raw",
        cooktime = 3,
    })

end
