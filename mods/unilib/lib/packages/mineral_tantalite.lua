---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tantalite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tantalite.init()

    return {
        description = "Tantalite (as mineral)",
        optional = "metal_tantalum",
    }

end

function unilib.pkg.mineral_tantalite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tantalite",
        description = S("Tantalite"),

        hardness = 3,
        metal_list = {"tantalum"},
    })

    unilib.register_craftitem("unilib:mineral_tantalite_lump", nil, mode, {
        -- Original to unilib
        description = S("Tantalite Lump"),
        inventory_image = "unilib_mineral_tantalite_lump.png",
    })
    if unilib.pkg_executed_table["metal_tantalum"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_tantalum_ingot",
            recipe = "unilib:mineral_tantalite_lump",
        })

    end

end
