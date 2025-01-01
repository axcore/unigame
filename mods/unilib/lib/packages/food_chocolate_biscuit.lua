---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chocolate_biscuit = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chocolate_biscuit.init()

    return {
        description = "Chocolate biscuit",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_chocolate_biscuit.exec()

    unilib.register_craftitem("unilib:food_chocolate_biscuit", "farming:cookie", mode, {
        -- From farming:cookie
        description = S("Cookie"),
        inventory_image = "unilib_food_chocolate_biscuit.png",
        -- N.B. No groups in original code
        groups = {food_chocolate = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_chocolate_biscuit", 2),
    })
    unilib.register_craft( {
        -- From farming:cookie
        output = "unilib:food_chocolate_biscuit 8",
        recipe = {
            {"group:food_wheat", "group:food_cocoa", "group:food_wheat"},
        },
    })

end
