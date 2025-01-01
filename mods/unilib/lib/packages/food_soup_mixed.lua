---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_mixed.init()

    return {
        description = "Mixed soup",
        notes = "Crafted using a soup cauldron",
        depends = "utensil_bowl_wooden",
    }

end

function unilib.pkg.food_soup_mixed.exec()

    unilib.register_craftitem("unilib:food_soup_mixed", "xdecor:bowl_soup", mode, {
        -- From xdecor:bowl_soup
        description = S("Bowl of Mixed Soup"),
        inventory_image = "unilib_food_soup_mixed.png",
        groups = {not_in_creative_inventory = 1},

        stack_max = 1,
        wield_image = "unilib_food_soup_mixed.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_soup_mixed", 30, "unilib:utensil_bowl_wooden"
        ),
    })

end
