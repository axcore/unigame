---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_circuit_integrated = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_circuit_integrated.init()

    return {
        description = "Simple integrated circuit",
        depends = {"material_silicon", "metal_copper"},
    }

end

function unilib.pkg.component_circuit_integrated.exec()

    unilib.register_craftitem(
        -- From basic_materials:ic
        "unilib:component_circuit_integrated",
        {"basic_materials:ic", "homedecor:ic"},
        mode,
        {
            description = S("Simple Integrated Circuit"),
            inventory_image = "unilib_component_circuit_integrated.png",
        }
    )
    unilib.register_craft( {
        -- From basic_materials:ic
        output = "unilib:component_circuit_integrated 4",
        recipe = {
            {"unilib:material_silicon_lump", "unilib:material_silicon_lump"},
            {"unilib:material_silicon_lump", "unilib:metal_copper_ingot"},
        },
    })

end
