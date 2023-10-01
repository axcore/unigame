---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_onigiri = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_onigiri.init()

    return {
        description = "Onigiri",
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "ingredient_salt_normal",           -- group:food_salt
            "plant_seaweed_undersea",           -- group:food_seaweed
        },
    }

end

function unilib.pkg.food_onigiri.exec()

    unilib.register_craftitem("unilib:food_onigiri", "farming:onigiri", mode, {
        -- From farming:onigiri
        description = S("Onirigi"),
        inventory_image = "unilib_food_onigiri.png",
        -- N.B. no food_rice in original code
        groups = {flammable = 2, food_onigiri = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_onigiri", 2),
    })
    unilib.register_craft({
        -- From farming:onigiri
        output = "unilib:food_onigiri",
        recipe = {
            {"group:food_rice", "group:food_salt", "group:food_rice"},
            {"", "group:food_seaweed", ""},
        },
    })

end
