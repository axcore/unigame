---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_stew_hearty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_stew_hearty.init()

    return {
        description = "Hearty stew",
        depends = {"mushroom_brown", "utensil_bowl_wooden"},
        suggested = {
            "fern_boston",                      -- group:food_tuber
            "produce_bean_green",               -- group:food_beans
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_stew_hearty.exec()

    unilib.register_craftitem("unilib:food_stew_hearty", "ethereal:hearty_stew", mode, {
        -- From ethereal:hearty_stew
        description = S("Hearty Stew"),
        inventory_image = "unilib_food_stew_hearty.png",
        -- N.B. No groups in original code
        groups = {food_stew = 1},

        wield_image = "unilib_food_stew_hearty.png",

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_stew_hearty", 10, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From ethereal:hearty_stew
        output = "unilib:food_stew_hearty",
        recipe = {
            {"group:food_onion", "unilib:mushroom_brown", "group:food_tuber"},
            {"", "unilib:mushroom_brown", ""},
            {"", "unilib:utensil_bowl_wooden", ""},
        },
    })
    unilib.register_craft({
        -- From ethereal:hearty_stew
        output = "unilib:food_stew_hearty",
        recipe = {
            {"group:food_onion", "unilib:mushroom_brown", "group:food_beans"},
            {"", "unilib:mushroom_brown", ""},
            {"", "unilib:utensil_bowl_wooden", ""},
        },
    })

end
