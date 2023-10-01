---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_unakite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_unakite.init()

    return {
        description = "Unakite (as a mineral)",
    }

end

function unilib.pkg.mineral_unakite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "unakite",
        description = S("Unakite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_unakite_lump", nil, mode, {
        -- Texture from AATO, unakite.png. Original code
        description = S("Unakite Lump"),
        inventory_image = "unilib_mineral_unakite_lump.png",
    })

end
