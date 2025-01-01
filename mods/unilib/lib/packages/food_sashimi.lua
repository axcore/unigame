---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sashimi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sashimi.init()

    return {
        description = "Sashimi",
        suggested = {
            "ingredient_fish_basic",            -- group:food_fish_raw
            "plant_seaweed_undersea",           -- group:food_seaweed
        },
    }

end

function unilib.pkg.food_sashimi.exec()

    unilib.register_craftitem("unilib:food_sashimi", "ethereal:sashimi", mode, {
        -- From ethereal:sashimi
        description = S("Sashimi"),
        inventory_image = "unilib_food_sashimi.png",
        -- N.B. food_sashimi = 1 not in original code
        groups = {flammable = 2, food_sashimi = 1},

        wield_image = "unilib_food_sashimi.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_sashimi", 4),
    })
    unilib.register_craft({
        -- From ethereal:sashimi
        output = "unilib:food_sashimi 2",
        recipe = {
            {"group:food_seaweed", "group:food_fish_raw", "group:food_seaweed"},
        },
    })

end
