---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_spinel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_spinel.init()

    return {
        description = "Spinel (as a mineral)",
    }

end

function unilib.pkg.mineral_spinel.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "spinel",
        description = S("Spinel"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_spinel_lump", nil, mode, {
        -- Texture from AATO, spinel.png. Original code
        description = S("Spinel Lump"),
        inventory_image = "unilib_mineral_spinel_lump.png",
    })

end
