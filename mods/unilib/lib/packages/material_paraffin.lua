---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_paraffin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_paraffin.init()

    return {
        description = "Paraffin",
        depends = "material_oil_extract",
    }

end

function unilib.pkg.material_paraffin.exec()

    unilib.register_craftitem("unilib:material_paraffin", "basic_materials:paraffin", mode, {
        -- From basic_materials:paraffin
        description = S("Unprocessed Paraffin"),
        inventory_image = "unilib_material_paraffin.png",
    })
    unilib.register_craft({
        -- From basic_materials:paraffin
        type = "cooking",
        output = "unilib:material_paraffin",
        recipe = "unilib:material_oil_extract",
    })
    unilib.register_craft({
        -- From basic_materials:paraffin
        type = "fuel",
        recipe = "unilib:material_paraffin",
        burntime = 30,
    })

end
