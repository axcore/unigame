---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_padlock_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_padlock_normal.init()

    return {
        description = "Normal padlock",
        depends = {"hardware_bar_steel", "metal_steel"},
    }

end

function unilib.pkg.item_padlock_normal.exec()

    unilib.register_craftitem("unilib:item_padlock_normal", "basic_materials:padlock", mode, {
        -- From basic_materials:padlock
        description = S("Normal Padlock"),
        inventory_image = "unilib_item_padlock_normal.png"
    })
    unilib.register_craft( {
        -- From basic_materials:padlock
        output = "unilib:item_padlock_normal 2",
        recipe = {
            {"unilib:hardware_bar_steel"},
            {"unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot"},
        },
    })

end
