---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_meat_imitation = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_meat_imitation.init()

    return {
        description = "Imitation meat",
        depends = {"dye_basic", "food_tofu_red"},
    }

end

function unilib.pkg.food_meat_imitation.exec()

    unilib.register_craftitem("unilib:food_meat_imitation", "cucina_vegana:imitation_meat", mode, {
        -- From cucina_vegana:imitation_meat
        description = S("Imitation Meat"),
        inventory_image = "unilib_food_meat_imitation.png",
        groups = {eatable = 1, food = 1, food_meat = 1, food_meat_raw = 1, food_vegan = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_meat_imitation", 3),
    })
    unilib.register_craft({
        -- From cucina_vegana:imitation_meat
        output = "unilib:food_meat_imitation",
        recipe = {
            {"unilib:dye_red", "unilib:food_tofu_red_raw", "unilib:dye_white"},
            {"", "unilib:food_tofu_red_raw", ""},
            {"", "unilib:food_tofu_red_raw", ""},
        },
    })

end
