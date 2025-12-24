---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_candy_cane_christmas = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_candy_cane_christmas.init()

    return {
        description = "Christmas candy cane",
        notes = "Dropped by the Evil Santa mob",
    }

end

function unilib.pkg.food_candy_cane_christmas.exec()

    unilib.register_craftitem("unilib:food_candy_cane_christmas", "petz:candy_cane", mode, {
        -- From petz:candy_cane
        description = S("Christmas Candy Cane"),
        inventory_image = "unilib_food_candy_cane_christmas.png",
        groups = {flammable = 2, food = 2},

        on_use = unilib.cuisine.eat_on_use("unilib:food_candy_cane_christmas", 6),
    })

end
