---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_andradite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_andradite.init()

    return {
        description = "Andradite (as a mineral)",
    }

end

function unilib.pkg.mineral_andradite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "andradite",
        description = S("Andradite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_andradite_lump", nil, mode, {
        -- Texture from AATO, andradite.png. Original code
        description = S("Andradite Lump"),
        inventory_image = "unilib_mineral_andradite_lump.png",
    })

end
