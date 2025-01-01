---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_wire_aluminium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_wire_aluminium.init()

    return {
        description = "Spool of aluminium wire",
        depends = {"item_spool_empty", "metal_aluminium"},
    }

end

function unilib.pkg.hardware_wire_aluminium.exec()

    unilib.register_craftitem(
        -- From basic_materials:aluminum_wire
        "unilib:hardware_wire_aluminium",
        "basic_materials:aluminum_wire",
        mode,
        {
            description = S("Spool of Aluminium Wire"),
            inventory_image = "unilib_hardware_wire_aluminium.png",
            groups = {wire = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:aluminum_wire
        type = "shapeless",
        output = "unilib:hardware_wire_aluminium 2",
        recipe = {
            "unilib:metal_aluminium_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
