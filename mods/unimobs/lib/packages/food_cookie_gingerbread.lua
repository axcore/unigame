---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cookie_gingerbread = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cookie_gingerbread.init()

    return {
        description = "Gingerbread cookie",
        notes = "Dropped by the Evil Santa mob",
    }

end

function unilib.pkg.food_cookie_gingerbread.exec()

    unilib.register_craftitem("unilib:food_cookie_gingerbread", "petz:gingerbread_cookie", mode, {
        -- From petz:gingerbread_cookie
        description = S("Gingerbread Cookie"),
        inventory_image = "unilib_food_cookie_gingerbread.png",
        groups = {flammable = 2, food = 2},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cookie_gingerbread", 8),
    })

end
