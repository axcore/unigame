---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_milk_coconut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_milk_coconut.init()

    return {
        description = "Coconut milk",
        depends = {"fruit_coconut", "utensil_board_cutting", "vessel_glass_empty"},
    }

end

function unilib.pkg.food_milk_coconut.exec()

    unilib.register_craftitem("unilib:food_milk_coconut", "moretrees:coconut_milk", mode, {
        -- From moretrees:coconut_milk
        description = S("Coconut Milk"),
        inventory_image = "unilib_food_milk_coconut_inv.png",
        -- N.B. no food_coconut_milk or food_milk_glass in original code
        groups = {food_milk_glass = 1, vessel = 1},

        wield_image = "unilib_food_milk_coconut.png",

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_milk_coconut", 2, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From moretrees:coconut_milk
        type = "shapeless",
        output = "unilib:food_milk_coconut",
        recipe = {
            "unilib:fruit_coconut",
            "unilib:vessel_glass_empty",
            "unilib:utensil_board_cutting",
        },
        replacements = {
            {"unilib:fruit_coconut", "unilib:fruit_coconut_slice"},
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
        },
    })

end
