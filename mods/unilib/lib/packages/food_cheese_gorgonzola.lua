---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_gorgonzola = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_gorgonzola.init()

    return {
        description = "Gorgonzola cheese",
        optional = "shared_cheese_rack",
    }

end

function unilib.pkg.food_cheese_gorgonzola.exec()

    unilib.register_craftitem("unilib:food_cheese_gorgonzola", "cheese:gorgonzola", mode, {
        -- From cheese:gorgonzola
        description = S("Gorgonzola"),
        inventory_image = "unilib_food_cheese_gorgonzola.png",
        groups = {food = 2, food_cheese = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cheese_gorgonzola", 2),
    })
    if unilib.global.pkg_executed_table["shared_cheese_rack"] ~= nil then
        unilib.pkg.shared_cheese_rack.register_custom_craft("gorgonzola")
    end

end
