---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_copper_wire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_copper_wire.init()

    return {
        description = "Spool of copper wire",
        depends = {"item_spool_empty", "metal_copper"},
    }

end

function unilib.pkg.metal_copper_wire.exec()

    unilib.register_craftitem("unilib:metal_copper_wire", "basic_materials:copper_wire", mode, {
        -- From basic_materials:copper_wire
        description = S("Spool of Copper Wire"),
        inventory_image = "unilib_metal_copper_wire.png",
        groups = {wire = 1},
    })
    unilib.register_craft( {
        -- From basic_materials:copper_wire
        type = "shapeless",
        output = "unilib:metal_copper_wire 2",
        recipe = {
            "unilib:metal_copper_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
