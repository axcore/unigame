---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_acanthite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_acanthite.init()

    return {
        description = "Acanthite (as mineral)",
        optional = "metal_silver",
    }

end

function unilib.pkg.mineral_acanthite.exec()

    local c_lump = "unilib:mineral_acanthite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "acanthite",
        description = S("Acanthite"),

        hardness = 1,
        metal_list = {"silver"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, acanthite.png). Original code
        description = S("Acanthite Lump"),
        inventory_image = "unilib_mineral_acanthite_lump.png",
    })
    if unilib.pkg_executed_table["metal_silver"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_silver_ingot",
            recipe = c_lump,
        })

    end

end
