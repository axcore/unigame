---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_wire_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_wire_silver.init()

    return {
        description = "Spool of silver wire",
        depends = {"item_spool_empty", "metal_silver"},
    }

end

function unilib.pkg.hardware_wire_silver.exec()

    unilib.register_craftitem(
        -- From basic_materials:silver_wire
        "unilib:hardware_wire_silver",
        {"basic_materials:silver_wire", "technic:fine_silver_wire"},
        mode,
        {
            description = S("Spool of Silver Wire"),
            inventory_image = "unilib_hardware_wire_silver.png",
            groups = {wire = 1},
        }
    )
    unilib.register_craft( {
        -- From basic_materials:silver_wire
        type = "shapeless",
        output = "unilib:hardware_wire_silver 2",
        recipe = {
            "unilib:metal_silver_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
