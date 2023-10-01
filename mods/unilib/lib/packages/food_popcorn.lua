---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_popcorn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_popcorn.init()

    return {
        description = "Popcorn",
        depends = {"utensil_pot_cooking", "vessel_bottle_glass_empty"},
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
            "produce_corn_normal",              -- group:food_corn
        },
    }

end

function unilib.pkg.food_popcorn.exec()

    unilib.register_craftitem("unilib:food_popcorn", "farming:popcorn", mode, {
        -- From farming:popcorn
        description = S("Popcorn"),
        inventory_image = "unilib_food_popcorn.png",
        groups = {flammable = 2, food_popcorn = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_popcorn", 4),
    })
    unilib.register_craft({
        -- From farming:popcorn
        output = "unilib:food_popcorn",
        recipe = {
            {"unilib:utensil_pot_cooking", "group:food_oil", "group:food_corn"},
        },
        replacements = {
            {"unilib:utensil_pot_cooking", "unilib:utensil_pot_cooking"},
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
