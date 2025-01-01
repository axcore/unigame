---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sushi_tamago = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sushi_tamago.init()

    return {
        description = "Tamago sushi",
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "plant_seaweed_undersea",           -- group:food_seaweed
        },
    }

end

function unilib.pkg.food_sushi_tamago.exec()

    unilib.register_craftitem("unilib:food_sushi_tamago", "ethereal:sushi_tamago", mode, {
        -- From ethereal:sushi_tamago
        description = S("Tamago Sushi"),
        inventory_image = "unilib_food_sushi_tamago.png",
        -- N.B. food_sushi = 1 not in original code
        groups = {flammable = 2, food_sushi = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_sushi_tamago", 2),
    })
    unilib.register_craft({
        -- From ethereal:sushi_tamago
        output = "unilib:food_sushi_tamago 2",
        recipe = {
            {"group:food_seaweed", "group:food_egg", "group:food_rice"},
        },
    })
    unilib.register_external_ingredient("unilib:food_sushi_tamago", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
