---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sugilite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sugilite.init()

    return {
        description = "Sugilite (as a mineral)",
    }

end

function unilib.pkg.mineral_sugilite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sugilite",
        description = S("Sugilite"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_sugilite_lump", nil, mode, {
        -- Texture from AATO, sugilite.png. Original code
        description = S("Sugilite Lump"),
        inventory_image = "unilib_mineral_sugilite_lump.png",
    })

end
