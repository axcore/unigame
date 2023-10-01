---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bread
-- Code:    MIT
-- Media:   CC0/CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_wholegrain_carrot = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bread.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_wholegrain_carrot.init()

    return {
        description = "Wholegrain carrot bread",
        depends = "ingredient_dough_wholegrain_carrot",
    }

end

function unilib.pkg.food_bread_wholegrain_carrot.exec()

    unilib.register_craftitem(
        -- From bread:wholegraincarrotbread
        "unilib:food_bread_wholegrain_carrot",
        "bread:wholegraincarrotbread",
        mode,
        {
            description = S("Wholegrain Carrot Bread"),
            inventory_image = "unilib_food_bread_wholegrain_carrot.png",
            groups = {flammable = 2, food_bread = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_bread_wholegrain_carrot", 8),
        }
    )
    unilib.register_craft({
        -- From bread:wholegraincarrotbread
        type = "cooking",
        output = "unilib:food_bread_wholegrain_carrot",
        recipe = "unilib:ingredient_dough_wholegrain_carrot",
        cooktime = 10,
    })

end
