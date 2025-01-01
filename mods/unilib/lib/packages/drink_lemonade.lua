---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_lemonade = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_lemonade.init()

    return {
        description = "Lemonade",
        depends = {"fruit_lemon", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.drink_lemonade.exec()

    unilib.register_node("unilib:drink_lemonade", "ethereal:lemonade", mode, {
        -- From ethereal:lemonade
        description = S("Lemonade"),
        tiles = {"unilib_drink_lemonade.png"},
        -- N.B. food_lemonade = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 3, drink = 1, flammable = 2, food_lemonade = 1,
            vessel = 1,
        },
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_drink_lemonade.png",
        -- N.B. is_ground_content = false not in original code; added to match other food items
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
        },
        walkable = false,
        wield_image = "unilib_drink_lemonade.png",

        on_use = unilib.cuisine.drink_on_use(
            "unilib:drink_lemonade", 5, "unilib:vessel_glass_empty"
        ),
    })

end

function unilib.pkg.drink_lemonade.post()

    unilib.register_craft({
        -- From ethereal:lemonade
        output = "unilib:drink_lemonade",
        recipe = {
            {"unilib:fruit_lemon", "group:food_sugar", "group:food_sugar"},
            {"unilib:vessel_glass_empty", "group:potable_bucket", ""},
        },
        replacements = unilib.global.potable_bucket_list,
    })

end
