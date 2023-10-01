---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_whey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_whey.init()

    return {
        description = "Whey",
        optional = "food_porridge",
    }

end

function unilib.pkg.ingredient_whey.exec()

    unilib.register_craftitem("unilib:ingredient_whey", "cheese:whey", mode, {
        -- From cheese:whey
        description = S("Whey"),
        inventory_image = "unilib_ingredient_whey.png",
        groups = {milk_product = 1},
    })

    if unilib.pkg_executed_table["food_porridge"] ~= nil then

        -- Alternative craft recipe for porridge, using whey instead of milk
        unilib.register_craft({
            -- From cheese:whey
            output = "unilib:food_porridge",
            recipe = {
                {"group:food_oats", "group:food_oats", "group:food_oats"},
                {"group:food_oats", "group:food_bowl", "unilib:ingredient_whey"}
            },
        })

    end

end
