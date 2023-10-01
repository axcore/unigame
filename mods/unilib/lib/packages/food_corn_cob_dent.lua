---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_corn_cob_dent = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_corn_cob_dent.init()

    return {
        description = "Dent Corn on the Cob",
        depends = "crop_corn_dent",
    }

end

function unilib.pkg.food_corn_cob_dent.exec()

    unilib.register_craftitem("unilib:food_corn_cob_dent", "cropocalypse:corn_on_the_cob", mode, {
        -- From cropocalypse:corn_on_the_cob
        description = S("Dent Corn On The Cob"),
        inventory_image = "unilib_food_corn_cob_dent.png",
        groups = {flammable = 1, food_corn_on_the_cob = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_corn_cob_dent", 4),
    })
    unilib.register_craft({
        -- From cropocalypse:corn_on_the_cob
        type = "cooking",
        output = "unilib:food_corn_cob_dent",
        recipe = "unilib:crop_corn_dent_harvest",
    })

end
