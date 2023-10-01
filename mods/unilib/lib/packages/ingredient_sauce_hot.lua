---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sauce_hot = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sauce_hot.init()

    return {
        description = "Hot sauce",
        depends = {"ingredient_paprika_smoked", "vessel_bottle_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_pepper_ground",         -- group:food_pepper_ground
        },
    }

end

function unilib.pkg.ingredient_sauce_hot.exec()

    unilib.register_node("unilib:ingredient_sauce_hot", "bbq:hot_sauce", mode, {
        -- From bbq:hot_sauce
        description = S("Hot Sauce"),
        tiles = {"unilib_ingredient_sauce_hot.png"},
        -- N.B. food_sauce = 1 not in original code
        groups = {attached_node = 1, dig_immediate = 3, food_sauce = 1, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_sauce_hot.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_sauce_hot.png",
    })

end

function unilib.pkg.ingredient_sauce_hot.post()

    unilib.register_craft({
        -- From bbq:hot_sauce
        type = "shapeless",
        output = "unilib:ingredient_sauce_hot",
        recipe = {
            "group:food_pepper_ground",
            "group:potable_bucket",
            "unilib:ingredient_paprika_smoked",
            "unilib:vessel_bottle_glass_empty",
        },
        replacements = unilib.potable_bucket_list,
    })

end
