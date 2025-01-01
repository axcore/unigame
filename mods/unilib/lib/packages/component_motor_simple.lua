---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_motor_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_motor_simple.init()

    return {
        description = "Simple motor",
        depends = {
            "hardware_wire_copper",
            "item_spool_empty",
            "material_plastic",
            "metal_copper",
            "metal_steel",
            "mineral_mese",
        },
    }

end

function unilib.pkg.component_motor_simple.exec()

    unilib.register_craftitem(
        -- From basic_materials:motor
        "unilib:component_motor_simple",
        {"basic_materials:motor", "homedecor:motor", "technic:motor"},
        mode,
        {
            description = S("Simple Motor"),
            inventory_image = "unilib_component_motor_simple.png",
        }
    )
    unilib.register_craft({
        -- From basic_materials:motor
        output = "unilib:component_motor_simple 2",
        recipe = {
            {
                "unilib:mineral_mese_crystal_fragment",
                "unilib:hardware_wire_copper",
                "unilib:material_plastic_sheet",
            },
            {
                "unilib:metal_copper_ingot",
                "unilib:metal_steel_ingot",
                "unilib:metal_steel_ingot",
            },
            {
                "unilib:mineral_mese_crystal_fragment",
                "unilib:hardware_wire_copper",
                "unilib:material_plastic_sheet",
            },
        },
        replacements = {
            {"unilib:hardware_wire_copper", "unilib:item_spool_empty"},
            {"unilib:hardware_wire_copper", "unilib:item_spool_empty"},
        },
    })

end
