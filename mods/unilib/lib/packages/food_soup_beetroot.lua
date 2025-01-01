---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_beetroot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_beetroot.init()

    return {
        description = "Beetroot soup",
        depends = "utensil_bowl_wooden",
        suggested = {
            "produce_beetroot_normal",          -- group:food_beetroot
        },
    }

end

function unilib.pkg.food_soup_beetroot.exec()

    unilib.register_craftitem("unilib:food_soup_beetroot", "farming:beetroot_soup", mode, {
        -- From farming:beetroot_soup
        description = S("Beetroot Soup"),
        inventory_image = "unilib_food_soup_beetroot.png",
        -- N.B. no food_beetroot in original code
        groups = {flammable = 2, food_beetroot_soup = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_soup_beetroot", 6, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:beetroot_soup
        output = "unilib:food_soup_beetroot",
        recipe = {
            {"group:food_beetroot", "group:food_beetroot", "group:food_beetroot"},
            {"group:food_beetroot", "unilib:utensil_bowl_wooden", "group:food_beetroot"},
        },
    })

end
