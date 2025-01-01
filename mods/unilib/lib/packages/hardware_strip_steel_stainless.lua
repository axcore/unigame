---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_strip_steel_stainless = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_strip_steel_stainless.init()

    return {
        description = "Stainless steel strip",
        depends = "metal_steel_stainless",
    }

end

function unilib.pkg.hardware_strip_steel_stainless.exec()

    unilib.register_craftitem(
        -- From basic_materials:stainless_steel_strip
        "unilib:hardware_strip_steel_stainless",
        "basic_materials:stainless_steel_strip",
        mode,
        {
            description = S("Stainless Steel Strip"),
            inventory_image = "unilib_hardware_strip_steel_stainless.png",
            groups = {strip = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:stainless_steel_strip
        output = "unilib:hardware_strip_steel_stainless 12",
        recipe = {
            {"", "unilib:metal_steel_stainless_ingot", ""},
            {"unilib:metal_steel_stainless_ingot", "", ""},
        },
    })

end
