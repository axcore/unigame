---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sauce_barbecue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sauce_barbecue.init()

    return {
        description = "BBQ sauce",
        depends = {"ingredient_liquid_smoke", "ingredient_molasses", "ingredient_vinegar"},
        suggested = {
            "ingredient_sauce_tomato",          -- group:food_tomato_sauce
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.ingredient_sauce_barbecue.exec()

    unilib.register_node("unilib:ingredient_sauce_barbecue", "bbq:bbq_sauce", mode, {
        -- From bbq:bbq_sauce
        description = S("BBQ Sauce"),
        tiles = {"unilib_ingredient_sauce_barbecue.png"},
        -- N.B. food_sauce = 1 not in original code
        groups = {attached_node = 1, dig_immediate = 3, food_sauce = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_sauce_barbecue.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_sauce_barbecue.png",
    })
    unilib.register_craft({
        -- From bbq:bbq_sauce
        type = "shapeless",
        output = "unilib:ingredient_sauce_barbecue",
        recipe = {
            "unilib:ingredient_molasses",
            "group:food_sugar",
            "group:food_tomato_sauce",
            "unilib:ingredient_liquid_smoke",
            "unilib:ingredient_vinegar",
        },
        replacements = {
            {"unilib:ingredient_vinegar", "unilib:ingredient_vinegar_mother"},
        },
    })

end
