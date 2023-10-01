---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_onion = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_onion.init()

    return {
        description = "Onion soup",
        depends = {"utensil_bowl_wooden", "utensil_pot_cooking"},
        suggested = {
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_soup_onion.exec()

    unilib.register_craftitem("unilib:food_soup_onion", "farming:onion_soup", mode, {
        -- From farming:onion_soup
        description = S("Onion Soup"),
        inventory_image = "unilib_food_soup_onion.png",
        -- N.B. no food_onion in original code
        groups = {flammable = 2, food_onion_soup = 1},

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_soup_onion", 6, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:onion_soup
        output = "unilib:food_soup_onion",
        recipe = {
            {"group:food_onion", "group:food_onion", "group:food_onion"},
            {"group:food_onion", "unilib:utensil_pot_cooking", "group:food_onion"},
            {"", "unilib:utensil_bowl_wooden", ""}
        },
        replacements = {
            {"unilib:utensil_pot_cooking", "unilib:utensil_pot_cooking"},
        },
    })

end
