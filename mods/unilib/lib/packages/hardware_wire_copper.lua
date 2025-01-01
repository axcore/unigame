---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_wire_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_wire_copper.init()

    return {
        description = "Spool of copper wire",
        depends = {"item_spool_empty", "metal_copper"},
    }

end

function unilib.pkg.hardware_wire_copper.exec()

    unilib.register_craftitem(
        -- From basic_materials:copper_wire
        "unilib:hardware_wire_copper",
        {"basic_materials:copper_wire", "homedecor:copper_wire", "technic:fine_copper_wire"},
        mode,
        {
            description = S("Spool of Copper Wire"),
            inventory_image = "unilib_hardware_wire_copper.png",
            groups = {wire = 1},
        }
    )
    unilib.register_craft( {
        -- From basic_materials:copper_wire
        type = "shapeless",
        output = "unilib:hardware_wire_copper 2",
        recipe = {
            "unilib:metal_copper_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
