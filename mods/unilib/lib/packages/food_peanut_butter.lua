---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_peanut_butter = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_peanut_butter.init()

    return {
        description = "Peanut butter",
        depends = {"crop_peanut", "item_stick_ordinary", "vessel_bottle_glass_empty"},
        suggested = {
            "ingredient_butter_normal",         -- group:food_butter
        },
    }

end

function unilib.pkg.food_peanut_butter.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:food_peanut_butter", "cucina_vegana:peanut_butter", mode, {
        -- From cucina_vegana:peanut_butter
        description = S("Peanut Butter"),
        tiles = {"unilib_food_peanut_butter.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, eatable = 1, food_butter = 1, food_sweet = 1,
            food_vegan = 1,
        },
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_peanut_butter.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_peanut_butter.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_peanut_butter", 10),
    })
    unilib.register_craft({
        -- From cucina_vegana:peanut_butter
        output = "unilib:food_peanut_butter",
        recipe = {
            {"unilib:crop_peanut_harvest", c_stick, "unilib:crop_peanut_harvest"},
            {"unilib:crop_peanut_harvest", "group:food_butter", "unilib:crop_peanut_harvest"},
            {"", "unilib:vessel_bottle_glass_empty", ""},
        },
        replacements = {
            {c_stick, c_stick},
        },
    })

end
