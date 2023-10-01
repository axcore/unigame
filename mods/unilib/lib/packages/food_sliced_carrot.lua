---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sliced_carrot = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sliced_carrot.init()

    return {
        description = "Sliced carrots",
        depends = "crop_carrot_danvers",
    }

end

function unilib.pkg.food_sliced_carrot.exec()

    local c_carrot = "unilib:crop_carrot_danvers_harvest"

    unilib.register_craftitem("unilib:food_sliced_carrot", "cropocalypse:sliced_carrots", mode, {
        -- From cropocalypse:sliced_carrots
        description = S("Sliced Carrots"),
        inventory_image = "unilib_food_sliced_carrot.png",
        groups = {flammable = 1, food_sliced_carrots = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_sliced_carrot", 2),
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:food_sliced_carrot 2",
        recipe = {c_carrot, c_carrot, c_carrot},
    })

end
