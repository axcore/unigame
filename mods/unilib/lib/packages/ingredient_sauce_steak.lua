---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sauce_steak = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sauce_steak.init()

    return {
        description = "Steak sauce",
        depends = {
            "ingredient_sauce_hot",
            "ingredient_vinegar",
            "mushroom_brown",
            "vessel_bottle_glass_empty",
        },
    }

end

function unilib.pkg.ingredient_sauce_steak.exec()

    unilib.register_node("unilib:ingredient_sauce_steak", "bbq:steak_sauce", mode, {
        -- From bbq:steak_sauce
        description = S("Steak Sauce"),
        tiles = {"unilib_ingredient_sauce_steak.png"},
        -- N.B. food_sauce = 1 not in original code
        groups = {attached_node = 1, dig_immediate = 3, food_sauce = 1, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_sauce_steak.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_sauce_steak.png",
    })
    unilib.register_craft({
        -- From bbq:steak_sauce
        type = "shapeless",
        output = "unilib:ingredient_sauce_steak",
        recipe = {
            "unilib:mushroom_brown",
            "unilib:ingredient_vinegar",
            "unilib:ingredient_sauce_hot",
            "unilib:vessel_bottle_glass_empty",
        },
        replacements = {
            {"unilib:ingredient_vinegar", "unilib:ingredient_vinegar_mother"},
        },
    })

end
