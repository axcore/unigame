---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_jam_blackberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_jam_blackberry.init()

    return {
        description = "Blackberry jam",
        depends = {"crop_cotton", "food_puree_blackberry"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_jam_blackberry.exec()

    unilib.register_node("unilib:food_jam_blackberry", nil, mode, {
        -- Original to unilib, based on the blueberry jam from cucina_vegana
        description = S("Blackberry Jam"),
        tiles = {"unilib_food_jam_blackberry.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, eatable = 1, food_sweet = 1, food_vegan = 1,
        },
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_jam_blackberry.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_jam_blackberry.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_jam_blackberry", 8, "unilib:vessel_bottle_glass_empty"
        ),
    })

end

function unilib.pkg.food_jam_blackberry.post()

    unilib.register_craft({
        -- Original to unilib, based on the blueberry jam recipe from cucina_vegana
        output = "unilib:food_jam_blackberry",
        recipe = {
            {"unilib:food_puree_blackberry", "", ""},
            {"group:food_sugar", "", ""},
            {"unilib:vessel_bottle_glass_empty", "", ""},
        },
    })

end
