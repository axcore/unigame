---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_plastic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_plastic.init()

    return {
        description = "Plastic",
        notes = "Provides plastic sheets and strips",
        depends = "material_paraffin",
    }

end

function unilib.pkg.material_plastic.exec()

    unilib.register_craftitem(
        -- From basic_materials:plastic_sheet
        "unilib:material_plastic_sheet",
        "basic_materials:plastic_sheet",
        mode,
        {
            description = S("Plastic Sheet"),
            inventory_image = "unilib_material_plastic_sheet.png",
        }
    )
    unilib.register_craft({
        -- From basic_materials:plastic_sheet
        type = "cooking",
        output = "unilib:material_plastic_sheet",
        recipe = "unilib:material_paraffin",
    })
    unilib.register_craft({
        -- From basic_materials:plastic_sheet
        type = "fuel",
        recipe = "unilib:material_plastic_sheet",
        burntime = 30,
    })

    unilib.register_craftitem(
        -- From basic_materials:plastic_strip
        "unilib:material_plastic_strip",
        "basic_materials:plastic_strip",
        mode,
        {
            description = S("Plastic Strips"),
            inventory_image = "unilib_material_plastic_strip.png",
            groups = {strip = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:plastic_strip
        output = "unilib:material_plastic_strip 9",
        recipe = {
            {
                "unilib:material_plastic_sheet",
                "unilib:material_plastic_sheet",
                "unilib:material_plastic_sheet",
            }
        },
    })

end
