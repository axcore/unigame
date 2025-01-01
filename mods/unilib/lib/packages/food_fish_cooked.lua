---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_cooked = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_cooked.init()

    return {
        description = "Cooked fish",
        notes = "Produced by cooking items from the \"ingredient_fish_basic\" package",
        depends = "ingredient_fish_basic",
    }

end

function unilib.pkg.food_fish_cooked.exec()

    unilib.register_craftitem("unilib:food_fish_cooked", "ethereal:fish_cooked", mode, {
        -- From ethereal:fish_cooked
        description = S("Cooked Fish"),
        inventory_image = "unilib_food_fish_cooked.png",
        groups = {flammable = 2, food_fish = 1},

        wield_image = "unilib_food_fish_cooked.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_fish_cooked", 5),
    })
    unilib.register_craft({
        -- From ethereal:fish_cooked
        type = "cooking",
        output = "unilib:food_fish_cooked",
        recipe = "group:food_fish_cookable",
        cooktime = 8,
    })

end
