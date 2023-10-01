---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_pungapunga = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_pungapunga.init()

    return {
        description = "Pungapunga pollen cake",
        depends = "plant_raupo",
    }

end

function unilib.pkg.food_cake_pungapunga.exec()

    unilib.register_craftitem("unilib:food_cake_pungapunga", "aotearoa:pungapunga", mode, {
        -- From aotearoa:pungapunga
        description = S("Pungapunga Pollen Cake"),
        inventory_image = "unilib_food_cake_pungapunga.png",
        -- N.B. No groups in original code
        groups = {food_pollen_cake = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cake_pungapunga", 2),
    })
    unilib.register_craft({
        -- From aotearoa:pungapunga
        type = "cooking",
        output = "unilib:food_cake_pungapunga",
        recipe = "unilib:plant_raupo_flower",
    })

end
