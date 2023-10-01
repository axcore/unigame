---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_amazonite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_amazonite.init()

    return {
        description = "Amazonite (as a mineral)",
    }

end

function unilib.pkg.mineral_amazonite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "amazonite",
        description = S("Amazonite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_amazonite_lump", nil, mode, {
        -- Texture from AATO, amazonite.png. Original code
        description = S("Amazonite Lump"),
        inventory_image = "unilib_mineral_amazonite_lump.png",
    })

end
