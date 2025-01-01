---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_fondue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_fondue.init()

    return {
        description = "Fondue cheese",
        depends = "metal_copper",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_cheese_fondue.exec()

    unilib.register_craftitem("unilib:food_cheese_fondue", "cheese:fondue", mode, {
        -- From cheese:fondue
        description = S("Fondue"),
        inventory_image = "unilib_food_cheese_fondue.png",
        groups = {food = 8},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_cheese_fondue", 8, "unilib:metal_copper_ingot 3"
        ),
    })
    unilib.register_craft({
        -- From cheese:fondue
        output = "unilib:food_cheese_fondue",
        recipe = {
            {"group:food_cheese", "", "group:food_cheese"},
            {"unilib:metal_copper_ingot", "group:food_cheese", "unilib:metal_copper_ingot"},
            {"", "unilib:metal_copper_ingot", ""},
        },
    })

end
