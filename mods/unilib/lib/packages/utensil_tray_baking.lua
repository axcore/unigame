---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_tray_baking = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_tray_baking.init()

    return {
        description = "Baking tray",
        depends = "brick_ordinary",
    }

end

function unilib.pkg.utensil_tray_baking.exec()

    local c_brick = "unilib:brick_ordinary"

    unilib.register_craftitem("unilib:utensil_tray_baking", "farming:baking_tray", mode, {
        -- From farming:baking_tray
        description = S("Baking Tray"),
        inventory_image = "unilib_utensil_tray_baking.png",
        groups = {flammable = 2, food_baking_tray = 1}
    })
    unilib.register_craft({
        -- From farming:baking_tray
        output = "unilib:utensil_tray_baking",
        recipe = {
            {c_brick, c_brick, c_brick},
            {c_brick, "", c_brick},
            {c_brick, c_brick, c_brick},
        }
    })

end
