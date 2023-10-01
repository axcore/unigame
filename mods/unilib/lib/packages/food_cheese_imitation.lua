---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_imitation = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_imitation.init()

    return {
        description = "Imitation cheese",
        depends = "dye_basic",
        suggested = {
            "ingredient_butter_imitation",      -- group:food_butter
        },
    }

end

function unilib.pkg.food_cheese_imitation.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:imitation_cheese
        "unilib:food_cheese_imitation",
        "cucina_vegana:imitation_cheese",
        mode,
        {
            description = S("Imitation Cheese"),
            inventory_image = "unilib_food_cheese_imitation.png",
            groups = {eatable = 1, food = 1, food_cheese = 1, food_vegan = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_imitation", 3),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:imitation_cheese
        output = "unilib:food_cheese_imitation",
        recipe = {
            {"unilib:dye_orange", "group:food_butter", "group:food_butter"},
        },
    })

end
