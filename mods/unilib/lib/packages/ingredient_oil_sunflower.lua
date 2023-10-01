---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_sunflower = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_sunflower.init()

    return {
        description = "Bottle of sunflower oil",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "crop_sunflower_giant",             -- group:food_sunflower_seeds
        },
    }

end

function unilib.pkg.ingredient_oil_sunflower.exec()

    unilib.register_node("unilib:ingredient_oil_sunflower", "farming:sunflower_oil", mode, {
        -- From farming:sunflower_oil
        description = S("Bottle of Sunflower Oil"),
        tiles = {"unilib_ingredient_oil_sunflower.png"},
        groups = {attached_node = 1, dig_immediate = 3, flammable = 2, food_oil = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_oil_sunflower.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_oil_sunflower.png",
    })
    unilib.register_craft( {
        -- From farming:sunflower_oil
        output = "unilib:ingredient_oil_sunflower",
        recipe = {
            {
                "group:food_sunflower_seeds",
                "group:food_sunflower_seeds",
                "group:food_sunflower_seeds",
            },
            {
                "group:food_sunflower_seeds",
                "group:food_sunflower_seeds",
                "group:food_sunflower_seeds",
            },
            {
                "group:food_sunflower_seeds",
                "unilib:vessel_bottle_glass_empty",
                "group:food_sunflower_seeds",
            },
        }
    })
    unilib.register_craft({
        -- From farming:sunflower_oil
        type = "fuel",
        recipe = "unilib:ingredient_oil_sunflower",
        burntime = 30,
        replacements = {
            {"unilib:ingredient_oil_sunflower", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
