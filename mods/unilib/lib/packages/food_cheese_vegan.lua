---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_vegan = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_vegan.init()

    return {
        description = "Vegan cheese",
        depends = {"food_milk_soy", "utensil_pot_cooking", "vessel_glass_empty"},
        optional = {"vessel_bottle_glass_ethanol", "vessel_bottle_glass_empty"},
        suggested = {
            "fruit_lemon",                      -- group:food_lemon
            "ingredient_cornstarch",            -- group:food_gelatin
            "ingredient_salt_normal",           -- group:food_salt
            "produce_pepper",                   -- group:food_peppercorn
        },
    }

end

function unilib.pkg.food_cheese_vegan.exec()

    unilib.register_craftitem("unilib:food_cheese_vegan", "farming:cheese_vegan", mode, {
        -- From farming:cheese_vegan
        description = S("Vegan Cheese"),
        inventory_image = "unilib_food_cheese_vegan.png",
        groups = {flammable = 2, food_cheese = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_vegan", 2),
    })
    unilib.register_craft({
        -- From farming:cheese_vegan
        output = "unilib:food_cheese_vegan",
        recipe = {
            {"unilib:food_milk_soy", "unilib:food_milk_soy", "unilib:food_milk_soy"},
            {"group:food_salt", "group:food_peppercorn", "group:food_lemon"},
            {"group:food_gelatin", "unilib:utensil_pot_cooking", ""}
        },
        replacements = {
            {"unilib:food_milk_soy", "unilib:vessel_glass_empty 3"},
            {"unilib:utensil_pot_cooking", "unilib:utensil_pot_cooking"},
        },
    })
    if unilib.pkg_executed_table["vessel_bottle_glass_ethanol"] ~= nil and
            unilib.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then

        unilib.register_craft({
            -- From farming:cheese_vegan
            output = "unilib:food_cheese_vegan",
            recipe = {
                {"unilib:food_milk_soy", "unilib:food_milk_soy", "unilib:food_milk_soy"},
                {"group:food_salt", "group:food_peppercorn", "unilib:vessel_bottle_glass_ethanol"},
                {"group:food_gelatin", "unilib:utensil_pot_cooking", ""}
            },
            replacements = {
                {"unilib:food_milk_soy", "unilib:vessel_glass_empty 3"},
                {"unilib:utensil_pot_cooking", "unilib:utensil_pot_cooking"},
                {"unilib:vessel_bottle_glass_ethanol", "unilib:vessel_bottle_glass_empty"},
            },
        })

    end

end
