---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_wire_steel_stainless = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_wire_steel_stainless.init()

    return {
        description = "Spool of stainless steel wire",
        depends = {"item_spool_empty", "metal_steel_stainless"},
    }

end

function unilib.pkg.hardware_wire_steel_stainless.exec()

    unilib.register_craftitem(
        -- From basic_materials:stainless_steel_wire
        "unilib:hardware_wire_steel_stainless",
        "basic_materials:stainless_steel_wire",
        mode,
        {
            description = S("Spool of Stainless Steel Wire"),
            inventory_image = "unilib_hardware_wire_steel_stainless.png",
            groups = {wire = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:stainless_steel_wire
        type = "shapeless",
        output = "unilib:hardware_wire_steel_stainless 2",
        recipe = {
            "unilib:metal_steel_stainless_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
