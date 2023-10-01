---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_opal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_opal.init()

    return {
        description = "Opal (as a mineral)",
    }

end

function unilib.pkg.mineral_opal.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "opal",
        description = S("Opal"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_opal_lump", nil, mode, {
        -- Texture from AATO, opal.png. Original code
        description = S("Opal Lump"),
        inventory_image = "unilib_mineral_opal_lump.png",
    })

end
