---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sushi_nigiri = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sushi_nigiri.init()

    return {
        description = "Nigiri sushi",
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "ingredient_fish_basic",            -- group:food_fish_raw
        },
    }

end

function unilib.pkg.food_sushi_nigiri.exec()

    unilib.register_craftitem("unilib:food_sushi_nigiri", "ethereal:sushi_nigiri", mode, {
        -- From ethereal:sushi_nigiri
        description = S("Nigiri Sushi"),
        inventory_image = "unilib_food_sushi_nigiri.png",
        -- N.B. food_sushi = 1 not in original code
        groups = {flammable = 2, food_sushi = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_sushi_nigiri", 2),
    })
    unilib.register_craft({
        -- From ethereal:sushi_nigiri
        output = "unilib:food_sushi_nigiri 2",
        recipe = {
            {"group:food_rice", "group:food_fish_raw", ""},
        },
    })

end
