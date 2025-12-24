---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_honey_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_honey_normal.init()

    return {
        description = "Normal honey",
        notes = "Obtained from normal beehives",
        depends = "vessel_bottle_glass_empty",
    }

end

function unilib.pkg.food_honey_normal.exec()

    unilib.register_craftitem("unilib:food_honey_normal", "petz:honey_bottle", mode, {
        -- From petz:honey_bottle
        description = S("Normal honey"),
        inventory_image = "unilib_food_honey_normal.png",
        groups = {food_honey = 1, food_sugar = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_honey_normal", 7, "unilib:vessel_bottle_glass_empty"
        ),
    })

end
