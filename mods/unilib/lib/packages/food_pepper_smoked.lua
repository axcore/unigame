---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pepper_smoked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pepper_smoked.init()

    return {
        description = "Smoked pepper",
        suggested = {
            "food_pepper",                      -- group:food_pepper
        },
    }

end

function unilib.pkg.food_pepper_smoked.exec()

    unilib.register_craftitem("unilib:food_pepper_smoked", "bbq:smoked_pepper", mode, {
        -- From bbq:smoked_pepper
        description = S("Smoked Pepper"),
        inventory_image = "unilib_food_pepper_smoked.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_pepper_smoked", 5),
    })
    unilib.register_craft({
        -- From bbq:smoked_pepper
        type = "cooking",
        output = "unilib:food_pepper_smoked",
        recipe = "group:food_pepper",
        cooktime = 9,
    })

end
