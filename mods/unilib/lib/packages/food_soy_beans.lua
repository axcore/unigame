---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soy_beans = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soy_beans.init()

    return {
        description = "Soy beans",
        depends = "produce_soy_normal",
    }

end

function unilib.pkg.food_soy_beans.exec()

    unilib.register_craftitem("unilib:food_soy_beans", "farming:soy_beans", mode, {
        -- From farming:soy_beans
        description = S("Soy Beans"),
        inventory_image = "unilib_food_soy_beans.png",
        groups = {flammable = 2, food_soy = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_soy_beans", 1),
    })
    unilib.register_craft({
        -- From farming:soy_beans
        output = "unilib:food_soy_beans",
        recipe = {
            {"unilib:produce_soy_normal_harvest"},
        },
    })

end
