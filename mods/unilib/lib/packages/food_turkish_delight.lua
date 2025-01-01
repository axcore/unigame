---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_turkish_delight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_turkish_delight.init()

    return {
        description = "Turkish Delight",
        depends = {
            "dye_basic",
            "utensil_bowl_wooden",
            "vessel_bottle_glass_empty",
            "vessel_bottle_glass_with_water_rose",
        },
        suggested = {
            "ingredient_cornstarch",            -- group:food_gelatin
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_turkish_delight.exec()

    unilib.register_craftitem("unilib:food_turkish_delight", "farming:turkish_delight", mode, {
        -- From farming:turkish_delight
        description = S("Turkish Delight"),
        inventory_image = "unilib_food_turkish_delight.png",
        -- N.B. no food_confectionery in original code
        groups = {flammable = 3, food_turkish_delight = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_turkish_delight", 2),
    })
    unilib.register_craft({
        -- From farming:turkish_delight
        output = "unilib:food_turkish_delight 4",
        recipe = {
            {"group:food_gelatin", "group:food_sugar", "group:food_gelatin"},
            {"group:food_sugar", "unilib:vessel_bottle_glass_with_water_rose", "group:food_sugar"},
            {"group:food_sugar", "unilib:dye_pink", "group:food_sugar"},
        },
        replacements = {
            {"group:food_cornstarch", "unilib:utensil_bowl_wooden"},
            {"group:food_rose_water", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
