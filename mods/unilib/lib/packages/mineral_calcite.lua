---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_calcite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_calcite.init()

    return {
        description = "Calcite (as mineral)",
        optional = "metal_calcium",
    }

end

function unilib.pkg.mineral_calcite.exec()

    local c_lump = "unilib:mineral_calcite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "calcite",
        description = S("Calcite"),

        hardness = 1,
        metal_list = {"calcium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, calcite.png). Original code
        description = S("Calcite Lump"),
        inventory_image = "unilib_mineral_calcite_lump.png",
    })
    if unilib.pkg_executed_table["metal_calcium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_calcium_chunk",
            recipe = c_lump,
        })

    end

end
