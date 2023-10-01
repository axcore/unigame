---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_potato_spanish = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_potato_spanish.init()

    return {
        description = "Spanish potatoes",
        depends = {
            "produce_garlic_normal",
            "produce_onion_normal",
            "produce_potato_normal",
            "utensil_bowl_wooden",
            "utensil_skillet_normal",
        },
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
            "produce_parsley_flatleaf",         -- group:food_parsley
        },
    }

end

function unilib.pkg.food_potato_spanish.exec()

    unilib.register_craftitem("unilib:food_potato_spanish", "farming:spanish_potatoes", mode, {
        -- From farming:spanish_potatoes
        description = unilib.brackets(S("Patatas a la importancia"), S("Spanish Potatoes")),
        inventory_image = "unilib_food_potato_spanish.png",
        -- N.B. No groups in original code
        groups = {food_spanish_potato = 1},

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_potato_spanish", 8, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:spanish_potatoes
        type = "shapeless",
        output = "unilib:food_potato_spanish",
        recipe = {
            "unilib:produce_potato_normal_harvest",
            "group:food_parsley",
            "unilib:produce_potato_normal_harvest",
            "group:food_egg",
            "group:food_flour",
            "unilib:produce_onion_normal_harvest",
            "unilib:produce_garlic_normal_clove",
            "unilib:utensil_bowl_wooden",
            "unilib:utensil_skillet_normal"
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })
    unilib.register_external_ingredient("unilib:food_potato_spanish", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
