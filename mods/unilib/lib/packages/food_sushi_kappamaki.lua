---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sushi_kappamaki = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sushi_kappamaki.init()

    return {
        description = "Kappa Maki sushi",
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "plant_seaweed_undersea",           -- group:food_seaweed
            "produce_cucumber_normal",          -- group:food_cucumber
        },
    }

end

function unilib.pkg.food_sushi_kappamaki.exec()

    unilib.register_craftitem("unilib:food_sushi_kappamaki", "ethereal:sushi_kappamaki", mode, {
        -- From ethereal:sushi_kappamaki
        description = S("Kappa Maki Sushi"),
        inventory_image = "unilib_food_sushi_kappamaki.png",
        -- N.B. food_sushi = 1 not in original code
        groups = {flammable = 2, food_sushi = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_sushi_kappamaki", 3),
    })
    unilib.register_craft({
        -- From ethereal:sushi_kappamaki
        output = "unilib:food_sushi_kappamaki 2",
        recipe = {
            {"group:food_seaweed", "group:food_cucumber", "group:food_rice"},
        },
    })

end
