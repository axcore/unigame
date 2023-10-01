---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_imitation = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_imitation.init()

    return {
        description = "Imitation fish",
        depends = {"dye_basic", "food_tofu_red"},
    }

end

function unilib.pkg.food_fish_imitation.exec()

    unilib.register_craftitem("unilib:food_fish_imitation", "cucina_vegana:imitation_fish", mode, {
        -- From cucina_vegana:imitation_fish
        description = S("Imitation Fish"),
        inventory_image = "unilib_food_fish_imitation.png",
        groups = {eatable = 1, food = 1, food_fish = 1, food_vegan = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_fish_imitation", 3),
    })
    unilib.register_craft({
        -- From cucina_vegana:imitation_fish
        output = "unilib:food_fish_imitation",
        recipe = {
            {"unilib:dye_blue", "unilib:food_tofu_red_raw", "unilib:dye_blue"},
            {"unilib:food_tofu_red_raw", "unilib:food_tofu_red_raw", "unilib:food_tofu_red_raw"},
            {"", "unilib:food_tofu_red_raw", ""},
        },
    })

end
