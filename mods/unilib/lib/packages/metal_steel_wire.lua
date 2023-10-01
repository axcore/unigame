---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_wire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_wire.init()

    return {
        description = "Spool of steel wire",
        depends = {"item_spool_empty", "metal_steel"},
    }

end

function unilib.pkg.metal_steel_wire.exec()

    unilib.register_craftitem("unilib:metal_steel_wire", "basic_materials:steel_wire", mode, {
        -- From basic_materials:steel_wire
        description = S("Spool of Steel Wire"),
        inventory_image = "unilib_metal_steel_wire.png",
        groups = {wire = 1},
    })
    unilib.register_craft( {
        -- From basic_materials:steel_wire
        type = "shapeless",
        output = "unilib:metal_steel_wire 2",
        recipe = {
            "unilib:metal_steel_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })

end
