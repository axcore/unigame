---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_skillet_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_skillet_normal.init()

    return {
        description = "Normal skillet",
        depends = "metal_steel",
    }

end

function unilib.pkg.utensil_skillet_normal.exec()

    unilib.register_craftitem("unilib:utensil_skillet_normal", "farming:skillet", mode, {
        -- From farming:skillet"
        description = S("Normal Skillet"),
        inventory_image = "unilib_utensil_skillet_normal.png",
        groups = {flammable = 2, food_skillet = 1}
    })
    unilib.register_craft({
        -- From farming:skillet"
        output = "unilib:utensil_skillet_normal",
        recipe = {
            {"unilib:metal_steel_ingot", "", ""},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "", "group:stick"},
        },
    })

end
