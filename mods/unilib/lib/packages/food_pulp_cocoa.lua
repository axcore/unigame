---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pulp_cocoa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pulp_cocoa.init()

    return {
        description = "Cocoa pulp",
        depends = {"crop_cocoa_trinitario", "utensil_bowl_wooden"},
    }

end

function unilib.pkg.food_pulp_cocoa.exec()

    unilib.register_craftitem("unilib:food_pulp_cocoa", "cropocalypse:cocao_pulp", mode, {
        -- From cropocalypse:cocao_pulp
        description = S("Cocoa Pulp"),
        inventory_image = "unilib_food_pulp_cocoa.png",
        groups = {flammable = 1, food_cocoa_pulp = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_pulp_cocoa", 1),
    })
    unilib.register_craft({
        -- From cropocalypse:cocao_pulp
        type = "shapeless",
        output = "unilib:food_pulp_cocoa",
        recipe = {
            "unilib:utensil_bowl_wooden",
            "unilib:crop_cocoa_trinitario_harvest",
            "unilib:crop_cocoa_trinitario_harvest",
            "unilib:crop_cocoa_trinitario_harvest",
        },
    })

end
