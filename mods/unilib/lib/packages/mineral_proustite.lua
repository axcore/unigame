---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_proustite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_proustite.init()

    return {
        description = "Proustite (as mineral)",
        optional = "metal_silver",
    }

end

function unilib.pkg.mineral_proustite.exec()

    local c_lump = "unilib:mineral_proustite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "proustite",
        description = S("Proustite"),

        hardness = 1,
        metal_list = {"silver"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, proustite.png). Original code
        description = S("Proustite Lump"),
        inventory_image = "unilib_mineral_proustite_lump.png",
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
