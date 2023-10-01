---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_crisps = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_crisps.init()

    return {
        description = "Crisps",
        suggested = {
            "produce_potato_normal",            -- group:food_potato
        },
    }

end

function unilib.pkg.food_crisps.exec()

    unilib.register_craftitem("unilib:food_crisps", "better_farming:chips", mode, {
        -- From better_farming:chips
        description = S("Crisps"),
        inventory_image = "unilib_food_crisps.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_crisps", 1),
    })
    unilib.register_craft({
        -- From better_farming:chips
        type = "cooking",
        output = "unilib:food_crisps 3",
        -- N.B. Original recipe used "better_farming:potatoes"
        recipe = "group:food_potato",
    })

end
