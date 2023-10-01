---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bar_date_nut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bar_date_nut.init()

    return {
        description = "Date and nut bar",
        depends = "food_cake_date_nut",
    }

end

function unilib.pkg.food_bar_date_nut.exec()

    unilib.register_craftitem("unilib:food_bar_date_nut", "moretrees:date_nut_bar", mode, {
        -- From moretrees:date_nut_bar
        description = S("Date-nut energy bar"),
        inventory_image = "unilib_food_bar_date_nut.png",
        -- N.B. No groups in original code
        groups = {food_date = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bar_date_nut", 4),
    })
    unilib.register_craft({
        -- From moretrees:date_nut_bar
        type = "shapeless",
        output = "unilib:food_bar_date_nut 8",
        recipe = {"unilib:food_cake_date_nut"},
    })

end
