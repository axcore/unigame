---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_element_heating = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_element_heating.init()

    return {
        description = "Heating element",
        depends = {"metal_copper", "mineral_mese"},
    }

end

function unilib.pkg.component_element_heating.exec()

    unilib.register_craftitem(
        -- From basic_materials:heating_element
        "unilib:component_element_heating",
        {"basic_materials:heating_element", "homedecor:heating_element"},
        mode,
        {
            description = S("Heating Element"),
            inventory_image = "unilib_component_element_heating.png",
        }
    )
    unilib.register_craft( {
        -- From basic_materials:heating_element
        output = "unilib:component_element_heating 2",
        recipe = {
            {
                "unilib:metal_copper_ingot",
                "unilib:mineral_mese_crystal_fragment",
                "unilib:metal_copper_ingot",
            },
        },
    })

end
