---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_oil_extract = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_oil_extract.init()

    return {
        description = "Oil extract",
    }

end

function unilib.pkg.material_oil_extract.exec()

    unilib.register_craftitem(
        -- From basic_materials:oil_extract
        "unilib:material_oil_extract",
        {"basic_materials:oil_extract", "homedecor:oil_extract"},
        mode,
        {
            description = S("Oil Extract"),
            inventory_image = "unilib_material_oil_extract.png",
        }
    )
    unilib.register_craft({
        -- From basic_materials:oil_extract
        type = "shapeless",
        output = "unilib:material_oil_extract 2",
        recipe = {
            "group:leaves",
            "group:leaves",
            "group:leaves",
            "group:leaves",
            "group:leaves",
            "group:leaves"
        },
    })
    unilib.register_craft({
        -- From basic_materials:oil_extract
        type = "fuel",
        recipe = "unilib:material_oil_extract",
        burntime = 30,
    })

end
