---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo (20241118 update)
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_mayonnaise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_mayonnaise.init()

    return {
        description = "Mayonnaise",
        depends = {"ingredient_oil_olive", "vessel_bottle_glass_empty"},
        suggested = {
            "fruit_lemon",                      -- group:food_lemon
            "ingredient_salt_normal",           -- group:food_salt
        },
    }

end

function unilib.pkg.ingredient_mayonnaise.exec()

    unilib.register_node("unilib:ingredient_mayonnaise", "farming:mayonnaise", mode, {
        -- From farming:mayonnaise
        description = S("Mayonnaise"),
        tiles = {"unilib_ingredient_mayonnaise.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, flammable = 2, food_mayonnaise = 1, vessel = 1,
        },
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_mayonnaise.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.45, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_mayonnaise.png",

        on_use = unilib.cuisine.eat_on_use("unilib:ingredient_mayonnaise", 3)
    })
    unilib.register_craft({
        -- From farming:mayonnaise
        output = "unilib:ingredient_mayonnaise",
        recipe = {
            {"unilib:ingredient_oil_olive", "group:food_lemon"},
            {"group:food_egg", "group:food_salt"},
        },
        replacements = {
            {"unilib:ingredient_oil_olive", "unilib:vessel_bottle_glass_empty"},
        },
    })
    unilib.register_external_ingredient("unilib:ingredient_mayonnaise", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
