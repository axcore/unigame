---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_strip_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_strip_copper.init()

    return {
        description = "Copper strip",
        depends = "metal_copper",
    }

end

function unilib.pkg.hardware_strip_copper.exec()

    unilib.register_craftitem(
        -- From basic_materials:copper_strip
        "unilib:hardware_strip_copper",
        {"basic_materials:copper_strip", "homedecor:copper_strip"},
        mode,
        {
            description = S("Copper Strip"),
            inventory_image = "unilib_hardware_strip_copper.png",
            groups = {strip = 1},
        }
    )
    unilib.register_craft( {
        -- From basic_materials:copper_strip
        output = "unilib:hardware_strip_copper 12",
        recipe = {
            {"", "unilib:metal_copper_ingot", ""},
            {"unilib:metal_copper_ingot", "", ""},
        },
    })

end
