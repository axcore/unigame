---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hemimorphite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hemimorphite.init()

    return {
        description = "Hemimorphite (as mineral)",
        optional = "metal_zinc",
    }

end

function unilib.pkg.mineral_hemimorphite.exec()

    local c_lump = "unilib:mineral_hemimorphite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "hemimorphite",
        description = S("Hemimorphite"),

        hardness = 2,
        metal_list = {"zinc"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, hemimorphite.png). Original code
        description = S("Hemimorphite Lump"),
        inventory_image = "unilib_mineral_hemimorphite_lump.png",
    })
    if unilib.pkg_executed_table["metal_zinc"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_zinc_ingot",
            recipe = c_lump,
        })

    end

end
