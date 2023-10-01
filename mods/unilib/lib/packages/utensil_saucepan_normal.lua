---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_saucepan_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_saucepan_normal.init()

    return {
        description = "Normal saucepan",
        depends = "metal_steel",
    }

end

function unilib.pkg.utensil_saucepan_normal.exec()

    unilib.register_craftitem("unilib:utensil_saucepan_normal", "farming:saucepan", mode, {
        -- From farming:saucepan
        description = S("Normal Saucepan"),
        inventory_image = "unilib_utensil_saucepan_normal.png",
        groups = {flammable = 2, food_saucepan = 1},
    })
    unilib.register_craft({
        -- From farming:saucepan
        output = "unilib:utensil_saucepan_normal",
        recipe = {
            {"unilib:metal_steel_ingot", "", ""},
            {"", "group:stick", ""}
        }
    })

end
