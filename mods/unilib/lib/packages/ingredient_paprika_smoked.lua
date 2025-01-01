---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_paprika_smoked = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_paprika_smoked.init()

    return {
        description = "Smoked paprika",
        depends = "food_pepper_smoked",
    }

end

function unilib.pkg.ingredient_paprika_smoked.exec()

    unilib.register_node("unilib:ingredient_paprika_smoked", "bbq:paprika", mode, {
        -- From bbq:paprika
        description = S("Smoked Paprika"),
        tiles = {"unilib_ingredient_paprika_smoked.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_paprika_smoked.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_paprika_smoked.png",
    })
    unilib.register_craft({
        -- From bbq:paprika
        output = "unilib:ingredient_paprika_smoked",
        recipe = {
            {"unilib:food_pepper_smoked"},
        },
    })

end
