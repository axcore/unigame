---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_omelette_potato = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_omelette_potato.init()

    return {
        description = "Potato omelette",
        depends = {"utensil_bowl_wooden", "utensil_skillet_normal"},
        suggested = {
            "produce_onion_normal",             -- group:food_onion
            "produce_potato_normal",            -- group:food_potato
        },
    }

end

function unilib.pkg.food_omelette_potato.exec()

    unilib.register_craftitem("unilib:food_omelette_potato", "farming:potato_omelet", mode, {
        -- From farming:potato_omelet
        description = S("Potato Omelette"),
        inventory_image = "unilib_food_omelette_potato.png",
        -- N.B. No groups in original code
        groups = {food_potato_omelette = 1},

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_omelette_potato", 6, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:potato_omelet
        type = "shapeless",
        output = "farming:potato_omelet",
        recipe = {
            "group:food_egg",
            "group:food_onion",
            "group:food_potato",
            "unilib:utensil_skillet_normal",
            "unilib:utensil_bowl_wooden",
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })
    unilib.register_external_ingredient("unilib:food_omelette_potato", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
