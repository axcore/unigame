---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_anhydrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_anhydrite.init()

    return {
        description = "Anhydrite (as mineral)",
        optional = "metal_calcium",
    }

end

function unilib.pkg.mineral_anhydrite.exec()

    local c_lump = "unilib:mineral_anhydrite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "anhydrite",
        description = S("Anhydrite"),

        hardness = 2,
        metal_list = {"calcium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, anhydrite.png). Original code
        description = S("Anhydrite Lump"),
        inventory_image = "unilib_mineral_anhydrite_lump.png",
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
