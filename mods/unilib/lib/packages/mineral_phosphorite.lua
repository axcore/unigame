---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_phosphorite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_phosphorite.init()

    return {
        description = "Phosphorite (as mineral)",
        optional = "substance_phosphorus",
    }

end

function unilib.pkg.mineral_phosphorite.exec()

    local c_lump = "unilib:mineral_phosphorite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "phosphorite",
        description = S("Phosphorite"),

        hardness = 3,
        non_metal_list = {"phosphorus"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, phosphorite.png). Original code
        description = S("Phosphorite Lump"),
        inventory_image = "unilib_mineral_phosphorite_lump.png",
    })
    if unilib.global.pkg_executed_table["substance_phosphorus"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:substance_phosphorus_sample",
            recipe = c_lump,
        })

    end

end
