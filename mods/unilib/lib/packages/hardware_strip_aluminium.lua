---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_strip_aluminium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_strip_aluminium.init()

    return {
        description = "Aluminium strip",
        depends = "metal_aluminium",
    }

end

function unilib.pkg.hardware_strip_aluminium.exec()

    unilib.register_craftitem(
        -- From basic_materials:aluminum_strip
        "unilib:hardware_strip_aluminium",
        "basic_materials:aluminum_strip",
        mode,
        {
            description = S("Aluminium Strip"),
            inventory_image = "unilib_hardware_strip_aluminium.png",
            groups = {strip = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:aluminum_strip
        output = "unilib:hardware_strip_aluminium 12",
        recipe = {
            {"", "unilib:metal_aluminium_ingot", ""},
            {"unilib:metal_aluminium_ingot", "", ""},
        },
    })

end
