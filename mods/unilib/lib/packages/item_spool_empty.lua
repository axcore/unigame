---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_spool_empty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_spool_empty.init()

    return {
        description = "Empty wire spool",
        depends = "material_plastic",
    }

end

function unilib.pkg.item_spool_empty.exec()

    local c_sheet = "unilib:material_plastic_sheet"

    unilib.register_craftitem("unilib:item_spool_empty", "basic_materials:empty_spool", mode, {
        -- From basic_materials:empty_spool
        description = S("Empty Wire Spool"),
        inventory_image = "unilib_item_spool_empty.png"
    })
    unilib.register_craft( {
        -- From basic_materials:empty_spool
        output = "unilib:item_spool_empty 3",
        recipe = {
            {c_sheet, c_sheet, c_sheet},
            {"", c_sheet, ""},
            {c_sheet, c_sheet, c_sheet},
        },
    })

end
