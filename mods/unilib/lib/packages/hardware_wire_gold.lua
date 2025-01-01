---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_wire_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_wire_gold.init()

    return {
        description = "Spool of gold wire",
        depends = {"item_spool_empty", "metal_gold"},
    }

end

function unilib.pkg.hardware_wire_gold.exec()

    unilib.register_craftitem(
        -- From basic_materials:gold_wire
        "unilib:hardware_wire_gold",
        {"basic_materials:gold_wire", "technic:fine_gold_wire"},
        mode,
        {
            description = S("Spool of Gold Wire"),
            inventory_image = "unilib_hardware_wire_gold.png",
            groups = {wire = 1},
        }
    )
    unilib.register_craft( {
        -- From basic_materials:gold_wire
        type = "shapeless",
        output = "unilib:hardware_wire_gold 2",
        recipe = {
            "unilib:metal_gold_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
