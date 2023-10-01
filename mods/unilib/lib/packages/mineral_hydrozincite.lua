---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hydrozincite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hydrozincite.init()

    return {
        description = "Hydrozincite (as mineral)",
        optional = "metal_zinc",
    }

end

function unilib.pkg.mineral_hydrozincite.exec()

    local c_lump = "unilib:mineral_hydrozincite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "hydrozincite",
        description = S("Hydrozincite"),

        hardness = 1,
        metal_list = {"zinc"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, hydrozincite.png). Original code
        description = S("Hydrozincite Lump"),
        inventory_image = "unilib_mineral_hydrozincite_lump.png",
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
