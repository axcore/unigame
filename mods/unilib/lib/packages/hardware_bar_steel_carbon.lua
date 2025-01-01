---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_bar_steel_carbon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_bar_steel_carbon.init()

    return {
        description = "Carbon steel bar",
        depends = "metal_steel_carbon",
    }

end

function unilib.pkg.hardware_bar_steel_carbon.exec()

    unilib.register_craftitem(
        -- From basic_materials:carbon_steel_bar
        "unilib:hardware_bar_steel_carbon",
        "basic_materials:carbon_steel_bar",
        mode,
        {
            description = S("Carbon Steel Bar"),
            inventory_image = "unilib_hardware_bar_carbon_steel.png",
        }
    )
    unilib.register_craft( {
        -- From basic_materials:carbon_steel_bar
        output = "unilib:hardware_bar_steel_carbon 6",
        recipe = {
            {"", "", "unilib:metal_steel_carbon_ingot"},
            {"", "unilib:metal_steel_carbon_ingot", ""},
            {"unilib:metal_steel_carbon_ingot", "", ""},
        },
    })

end
