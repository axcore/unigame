---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chrysoprase = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chrysoprase.init()

    return {
        description = "Chrysoprase (as a mineral)",
    }

end

function unilib.pkg.mineral_chrysoprase.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "chrysoprase",
        description = S("Chrysoprase"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_chrysoprase_lump", nil, mode, {
        -- Texture from AATO, chrysoprase.png. Original code
        description = S("Chrysoprase Lump"),
        inventory_image = "unilib_mineral_chrysoprase_lump.png",
    })

end
