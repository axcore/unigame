---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pyrope = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pyrope.init()

    return {
        description = "Pyrope (as a mineral)",
    }

end

function unilib.pkg.mineral_pyrope.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pyrope",
        description = S("Pyrope"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_pyrope_lump", nil, mode, {
        -- Texture from AATO, pyrope.png. Original code
        description = S("Pyrope Lump"),
        inventory_image = "unilib_mineral_pyrope_lump.png",
    })

end
