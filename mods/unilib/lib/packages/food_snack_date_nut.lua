---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_snack_date_nut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_snack_date_nut.init()

    return {
        description = "Date and nut snack",
        depends = {"food_nuts_cedar", "food_nuts_fir_douglas", "food_nuts_spruce", "fruit_date"},
    }

end

function unilib.pkg.food_snack_date_nut.exec()

    unilib.register_craftitem("unilib:food_snack_date_nut", "moretrees:date_nut_snack", mode, {
        -- From moretrees:date_nut_snack
        description = S("Date and Nut Snack"),
        inventory_image = "unilib_food_snack_date_nut.png",
        -- N.B. No groups in original code
        groups = {food_date = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_snack_date_nut", 4),
    })
    unilib.register_craft({
        -- From moretrees:date_nut_snack
        type = "shapeless",
        output = "unilib:food_snack_date_nut",
        recipe = {
            "unilib:fruit_date",
            "unilib:fruit_date",
            "unilib:fruit_date",
            "unilib:food_nuts_cedar",
            "unilib:food_nuts_fir_douglas",
            "unilib:food_nuts_spruce",
        },
    })

end
