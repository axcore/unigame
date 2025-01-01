---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_honey_synthetic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_honey_synthetic.init()

    return {
        description = "Synthetic honey",
        depends = "misc_hive_artificial",
    }

end

function unilib.pkg.food_honey_synthetic.exec()

    unilib.register_craftitem("unilib:food_honey_synthetic", "xdecor:honey", mode, {
        -- From xdecor:honey
        description = S("Synthetic Honey"),
        inventory_image = "unilib_food_honey_synthetic.png",
        -- N.B. removed not_in_creative_inventory = 1 from original code
--      groups = {flammable = 2, food_honey = 1, food_sugar = 1, not_in_creative_inventory = 1},
        groups = {flammable = 2, food_honey = 1, food_sugar = 1},

        wield_image = "unilib_food_honey_synthetic.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_honey_synthetic", 2),
    })

end
