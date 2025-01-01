---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_franklinite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_franklinite.init()

    return {
        description = "Franklinite (as mineral)",
        optional = "metal_zinc",
    }

end

function unilib.pkg.mineral_franklinite.exec()

    local c_lump = "unilib:mineral_franklinite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "franklinite",
        description = S("Franklinite"),

        hardness = 3,
        metal_list = {"zinc"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, franklinite.png). Original code
        description = S("Franklinite Lump"),
        inventory_image = "unilib_mineral_franklinite_lump.png",
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
