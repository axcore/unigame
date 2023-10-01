---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken_imitation_fryer = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken_imitation_fryer.init()

    return {
        description = "Imitation chicken fryer",
        depends = {
            "crop_parsley_curly",
            "crop_rosemary",
            "food_chicken_imitation",
            "ingredient_molasses",
            "item_paper_ordinary",
            "vessel_glass_empty",
        },
    }

end

function unilib.pkg.food_chicken_imitation_fryer.exec()

    local c_molasses = "unilib:ingredient_molasses"

    unilib.register_node(
        -- From cucina_vegana:fryer_raw
        "unilib:food_chicken_imitation_fryer_raw",
        "cucina_vegana:fryer_raw",
        mode,
        {
            description = S("Uncooked Imitation Chicken Fryer"),
            tiles = {"unilib_food_chicken_imitation_fryer_raw.png"},
            groups = {attached_node = 1, dig_immediate = 3, food_vegan = 1},
            -- (no sounds)

            drawtype = "plantlike",
            inventory_image = "unilib_food_chicken_imitation_fryer_raw.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_chicken_imitation_fryer_raw.png",
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:fryer_raw
        output = "unilib:food_chicken_imitation_fryer_raw",
        recipe = {
            {"unilib:item_paper_ordinary", "", "unilib:item_paper_ordinary"},
            {"unilib:crop_parsley_curly_harvest", c_molasses, "unilib:crop_rosemary_harvest"},
            {"", "unilib:food_chicken_imitation", ""},
        },
        replacements = {
            {"unilib:ingredient_molasses", "unilib:vessel_glass_empty"},
        },
    })

    unilib.register_node(
        -- From cucina_vegana:fryer
        "unilib:food_chicken_imitation_fryer_cooked",
        "cucina_vegana:fryer",
        mode,
        {
            description = S("Cooked Imitation Chicken Fryer"),
            tiles = {"unilib_food_chicken_imitation_fryer_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1, food_vegan = 1},
            -- (no sounds)

            drawtype = "plantlike",
            inventory_image = "unilib_food_chicken_imitation_fryer_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_chicken_imitation_fryer_cooked.png",

            on_use = unilib.cuisine_eat_on_use("unilib:food_chicken_imitation_fryer_cooked", 8),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:fryer
        type = "cooking",
        output = "unilib:food_chicken_imitation_fryer_cooked",
        recipe = "unilib:food_chicken_imitation_fryer_raw",
        cooktime = 25,
    })

end
