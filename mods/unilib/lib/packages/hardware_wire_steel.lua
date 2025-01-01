---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_wire_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_wire_steel.init()

    return {
        description = "Spool of steel wire",
        depends = {"item_spool_empty", "metal_steel"},
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.hardware_wire_steel.exec()

    unilib.register_craftitem(
        -- From basic_materials:steel_wire
        "unilib:hardware_wire_steel",
        {"basic_materials:steel_wire", "homedecor:steel_wire"},
        mode,
        {
            description = S("Spool of Steel Wire"),
            inventory_image = "unilib_hardware_wire_steel.png",
            groups = {wire = 1},
        }
    )
    unilib.register_craft( {
        -- From basic_materials:steel_wire
        type = "shapeless",
        output = "unilib:hardware_wire_steel 2",
        recipe = {
            "unilib:metal_steel_ingot",
            "unilib:item_spool_empty",
            "unilib:item_spool_empty",
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel",
            recipe = {
                {"unilib:hardware_wire_steel"},
            },
        })

    end

end
