---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_frog_leg = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_frog_leg.init()

    return {
        description = "Frog leg",
    }

end

function unilib.pkg.food_frog_leg.exec()

    unilib.register_craftitem("unilib:food_frog_leg_raw", "petz:frog_leg", mode, {
        -- From petz:frog_leg
        description = S("Raw Frog Leg"),
        inventory_image = "unilib_food_frog_leg_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_frog_leg_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_frog_leg_raw", 1),
    })

    unilib.register_craftitem("unilib:food_frog_leg_roasted", "petz:frog_leg_roasted", mode, {
        -- From petz:frog_leg_roasted
        description = S("Roasted Frog Leg"),
        inventory_image = "unilib_food_frog_leg_roasted.png",
        groups = {flammable = 2, food = 2, food_meat = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_frog_leg_roasted", 3),
    })
    unilib.register_craft({
        -- From petz:frog_leg_roasted
        type = "cooking",
        output = "unilib:food_frog_leg_roasted",
        recipe = "unilib:food_frog_leg_raw",
        cooktime = 2,
    })

end
