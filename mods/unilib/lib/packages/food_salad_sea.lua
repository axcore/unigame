---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_salad_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_salad_sea.init()

    return {
        description = "Sea salad",
        depends = "utensil_bowl_glass",
    }

end

function unilib.pkg.food_salad_sea.exec()

    unilib.register_node("unilib:food_salad_sea", "cucina_vegana:sea_salad", mode, {
        -- From cucina_vegana:sea_salad
        description = S("Sea Salad"),
        tiles = {"unilib_food_salad_sea.png"},
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_salad_sea.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_salad_sea.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_salad_sea", 5, "unilib:utensil_bowl_glass"),
    })

end
