---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_paella = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_paella.init()

    return {
        description = "Paella",
        depends = {
            "dye_basic",
            "produce_pepper",
            "utensil_bowl_wooden",
            "utensil_skillet_normal",
        },
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "food_pea",                         -- group:food_peas
        },
    }

end

function unilib.pkg.food_paella.exec()

    unilib.register_craftitem("unilib:food_paella", "farming:paella", mode, {
        -- From farming:paella
        description = S("Paella"),
        inventory_image = "unilib_food_paella.png",
        -- N.B. No groups in original code
        groups = {food_paella = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_paella", 8, "unilib:utensil_bowl_wooden"),
    })
    unilib.register_craft({
        -- From farming:paella
        type = "shapeless",
        output = "unilib:food_paella",
        recipe = {
            "group:food_rice",
            "unilib:dye_orange",
            "unilib:food_pepper_red",
            "group:food_peas",
            "group:food_chicken",
            "unilib:utensil_bowl_wooden",
            "unilib:utensil_skillet_normal",
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })
    unilib.register_external_ingredient("unilib:food_paella", {
        "group:food_chicken",                   -- Originally group:food_chicken
    })

end
