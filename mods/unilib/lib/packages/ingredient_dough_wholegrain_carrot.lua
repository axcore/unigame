---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bread
-- Code:    MIT
-- Media:   CC0/CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_wholegrain_carrot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bread.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_wholegrain_carrot.init()

    return {
        description = "Wholegrain carrot dough",
        depends = {
            "food_seed_sunflower_toasted",
            "ingredient_flour_ordinary",
            "produce_carrot_normal",
            "vessel_glass_with_water",
        },
    }

end

function unilib.pkg.ingredient_dough_wholegrain_carrot.exec()

    local c_flour = "unilib:ingredient_flour_ordinary"

    unilib.register_craftitem(
        -- From bread:wholegraincarrotbread_dough
        "unilib:ingredient_dough_wholegrain_carrot",
        "bread:wholegraincarrotbread_dough",
        mode,
        {
            description = S("Wholegrain Carrot Bread Dough"),
            inventory_image = "unilib_ingredient_dough_wholegrain_carrot.png",
        }
    )
    unilib.register_craft({
        -- From bread:wholegraincarrotbread_dough
        output = "unilib:ingredient_dough_wholegrain_carrot",
        recipe = {
            {"", "unilib:food_seed_sunflower_toasted", ""},
            {c_flour, "unilib:vessel_glass_with_water", "unilib:produce_carrot_normal_harvest"},
        },
    })

end
