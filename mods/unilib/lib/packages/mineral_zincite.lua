---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_zincite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_zincite.init()

    return {
        description = "Zincite (as mineral)",
        optional = "metal_zinc",
    }

end

function unilib.pkg.mineral_zincite.exec()

    local c_lump = "unilib:mineral_zincite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "zincite",
        description = S("Zincite"),

        hardness = 2,
        metal_list = {"zinc"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, zincite.png). Original code
        description = S("Zincite Lump"),
        inventory_image = "unilib_mineral_zincite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_zinc"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_zinc_ingot",
            recipe = c_lump,
        })

    end

end
