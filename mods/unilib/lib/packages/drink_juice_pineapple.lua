---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_pineapple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_pineapple.init()

    return {
        description = "Pineapple juice",
        depends = {"utensil_juicer_normal", "vessel_glass_empty"},
        suggested = {
            "produce_pineapple",                -- group:food_pineapple
        },
    }

end

function unilib.pkg.drink_juice_pineapple.exec()

    local c_ring = "unilib:food_ring_pineapple"

    unilib.register_craftitem("unilib:drink_juice_pineapple", "farming:pineapple_juice", mode, {
        -- From farming:pineapple_juice
        description = S("Pineapple Juice"),
        inventory_image = "unilib_drink_juice_pineapple.png",
        -- N.B. no food_pineapple_juice in original code
        groups = {drink = 1, food_pineapple_juice = 1, vessel = 1},

        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_juice_pineapple", 4, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From farming:pineapple_juice
        output = "unilib:drink_juice_pineapple",
        recipe = {
            {c_ring, c_ring, c_ring},
            {"", "unilib:utensil_juicer_normal", ""},
            {"", "unilib:vessel_glass_empty", ""},
        },
        replacements = {
            {"unilib:utensil_juicer_normal", "unilib:utensil_juicer_normal"},
        },
    })
    unilib.register_craft({
        -- From farming:pineapple_juice
        output = "unilib:drink_juice_pineapple 2",
        recipe = {
            {"group:food_pineapple", ""},
            {"unilib:utensil_juicer_normal", ""},
            {"unilib:vessel_glass_empty", "unilib:vessel_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_juicer_normal", "unilib:utensil_juicer_normal"},
        },
    })

end
