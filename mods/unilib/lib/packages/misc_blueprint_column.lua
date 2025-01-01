---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_blueprint_column = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.columnia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_blueprint_column.init()

    return {
        description = "Column blueprint",
        notes = "This package is not named \"item_blueprint_column\", so that it matches the" ..
                " \"misc_blueprint_grill_smoker\" package",
        depends = {"item_paper_ordinary", "mineral_coal"},
    }

end

function unilib.pkg.misc_blueprint_column.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_craftitem("unilib:misc_blueprint_column", "columnia:blueprint", mode, {
        -- From columnia:blueprint
        description = "Column Blueprint",
        inventory_image = "unilib_misc_blueprint_column.png",
    })
    unilib.register_craft({
        -- From columnia:blueprint
        output = "unilib:misc_blueprint_column",
        recipe = {
            {c_paper, "group:stick", c_paper},
            {c_paper, "unilib:mineral_coal_lump", c_paper},
            {c_paper, "group:stick", c_paper},
        },
    })

end
