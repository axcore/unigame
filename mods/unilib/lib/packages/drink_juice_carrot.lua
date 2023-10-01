---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_carrot = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_carrot.init()

    return {
        description = "Carrot juice",
        depends = {"utensil_juicer_normal", "vessel_glass_empty"},
        suggested = {
            "produce_carrot_normal",            -- group:food_carrot
        },
    }

end

function unilib.pkg.drink_juice_carrot.exec()

    unilib.register_craftitem("unilib:drink_juice_carrot", "farming:carrot_juice", mode, {
        -- From farming:carrot_juice
        description = S("Carrot Juice"),
        inventory_image = "unilib_drink_juice_carrot.png",
        -- N.B. no food_carrot_juice in original code
        groups = {drink = 1, food_carrot_juice = 1, vessel = 1},

        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_juice_carrot", 4, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From farming:carrot_juice
        output = "unilib:drink_juice_carrot",
        recipe = {
            {"group:food_carrot"},
            {"unilib:utensil_juicer_normal"},
            {"unilib:vessel_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_juicer_normal", "unilib:utensil_juicer_normal"},
        },
    })

end
