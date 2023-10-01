---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken_imitation = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken_imitation.init()

    return {
        description = "Imitation chicken",
        depends = {"dye_basic", "food_tofu_red"},
    }

end

function unilib.pkg.food_chicken_imitation.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:imitation_poultry
        "unilib:food_chicken_imitation",
        "cucina_vegana:imitation_poultry",
        mode,
        {
            description = S("Imitation Chicken"),
            inventory_image = "unilib_food_chicken_imitation.png",
            groups = {food = 1, food_bird = 1, food_vegan = 1},
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:imitation_poultry
        output = "unilib:food_chicken_imitation",
        recipe = {
            {"unilib:food_tofu_red_raw", "", "unilib:dye_yellow"},
            {"", "unilib:food_tofu_red_raw", ""},
            {"unilib:food_tofu_red_raw", "unilib:food_tofu_red_raw", "unilib:food_tofu_red_raw"}
        },
    })

end
