---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tourmaline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tourmaline.init()

    return {
        description = "Tourmaline (as a mineral)",
    }

end

function unilib.pkg.mineral_tourmaline.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tourmaline",
        description = S("Tourmaline"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_tourmaline_lump", nil, mode, {
        -- Texture from AATO, tourmaline.png. Original code
        description = S("Tourmaline Lump"),
        inventory_image = "unilib_mineral_tourmaline_lump.png",
    })

end
