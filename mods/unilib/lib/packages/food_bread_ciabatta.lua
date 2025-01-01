---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_ciabatta = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_ciabatta.init()

    return {
        description = "Ciabatta bread",
        depends = "ingredient_dough_ciabatta",
    }

end

function unilib.pkg.food_bread_ciabatta.exec()

    unilib.register_node("unilib:food_bread_ciabatta", "cucina_vegana:ciabatta_bread", mode, {
        -- From cucina_vegana:ciabatta_bread
        description = S("Ciabatta Bread"),
        tiles = {"unilib_food_bread_ciabatta.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, eatable = 1, food_bread = 1, food_vegan = 1,
        },
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_bread_ciabatta.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_bread_ciabatta.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_ciabatta", 4),
    })
    unilib.register_craft({
        -- From cucina_vegana:ciabatta_bread
        type = "cooking",
        output = "unilib:food_bread_ciabatta",
        recipe = "unilib:ingredient_dough_ciabatta",
        cooktime = 17,
    })

end
