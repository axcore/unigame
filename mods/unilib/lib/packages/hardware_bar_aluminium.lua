---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_bar_aluminium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_bar_aluminium.init()

    return {
        description = "Aluminium bar",
        depends = "metal_aluminium",
    }

end

function unilib.pkg.hardware_bar_aluminium.exec()

    unilib.register_craftitem(
        -- From basic_materials:aluminum_bar
        "unilib:hardware_bar_aluminium",
        "basic_materials:aluminum_bar",
        mode,
        {
            description = S("Aluminium Bar"),
            inventory_image = "unilib_hardware_bar_aluminium.png",
        }
    )
    unilib.register_craft({
        -- From basic_materials:aluminum_bar
        output = "unilib:hardware_bar_aluminium 6",
        recipe = {
            {"", "", "unilib:metal_aluminium_ingot"},
            {"", "unilib:metal_aluminium_ingot", ""},
            {"unilib:metal_aluminium_ingot", "", ""},
        },
    })

end
