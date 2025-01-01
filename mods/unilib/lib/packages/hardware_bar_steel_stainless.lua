---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_bar_steel_stainless = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_bar_steel_stainless.init()

    return {
        description = "Stainless steel bar",
        depends = "metal_steel_stainless",
    }

end

function unilib.pkg.hardware_bar_steel_stainless.exec()

    unilib.register_craftitem(
        -- From basic_materials:stainless_steel_bar
        "unilib:hardware_bar_steel_stainless",
        "basic_materials:stainless_steel_bar",
        mode,
        {
            description = S("Stainless Steel Bar"),
            inventory_image = "unilib_hardware_bar_steel_stainless.png",
        }
    )
    unilib.register_craft({
        -- From basic_materials:stainless_steel_bar
        output = "unilib:hardware_bar_steel_stainless 6",
        recipe = {
            {"", "", "unilib:metal_steel_stainless_ingot"},
            {"", "unilib:metal_steel_stainless_ingot", ""},
            {"unilib:metal_steel_stainless_ingot", "", ""},
        },
    })

end
