---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_stracchino = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_stracchino.init()

    return {
        description = "Stracchino cheese",
        optional = "shared_cheese_rack",
    }

end

function unilib.pkg.food_cheese_stracchino.exec()

    unilib.register_craftitem("unilib:food_cheese_stracchino", "cheese:stracchino", mode, {
        -- From cheese:stracchino
        description = S("Stracchino"),
        inventory_image = "unilib_food_cheese_stracchino.png",
        groups = {food = 2, food_cheese = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_stracchino", 2),
    })
    if unilib.pkg_executed_table["shared_cheese_rack"] ~= nil then
        unilib.pkg.shared_cheese_rack.register_custom_craft("stracchino")
    end

end
