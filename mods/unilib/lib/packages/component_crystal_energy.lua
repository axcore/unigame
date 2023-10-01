---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_crystal_energy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_crystal_energy.init()

    return {
        description = "Simple energy crystal",
        depends = {"metal_gold", "mineral_diamond", "mineral_mese", "torch_ordinary"},
    }

end

function unilib.pkg.component_crystal_energy.exec()

    unilib.register_craftitem(
        -- From basic_materials:energy_crystal_simple
        "unilib:component_crystal_energy",
        "basic_materials:energy_crystal_simple",
        mode,
        {
            description = S("Simple Energy Crystal"),
            inventory_image = "unilib_component_crystal_energy.png",
        }
    )
    unilib.register_craft({
        -- From basic_materials:energy_crystal_simple
        output = "unilib:component_crystal_energy 2",
        recipe = {
            {
                "unilib:mineral_mese_crystal_fragment",
                "unilib:torch_ordinary",
                "unilib:mineral_mese_crystal_fragment",
            },
            {
                "unilib:mineral_diamond_gem",
                "unilib:metal_gold_ingot",
                "unilib:mineral_diamond_gem",
            }
        },
    })

end
