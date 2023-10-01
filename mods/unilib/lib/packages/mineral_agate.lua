---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_agate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_agate.init()

    return {
        description = "Agate (as a mineral)",
    }

end

function unilib.pkg.mineral_agate.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "agate",
        description = S("Agate"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_agate_lump", nil, mode, {
        -- Texture from AATO, agate.png. Original code
        description = S("Agate Lump"),
        inventory_image = "unilib_mineral_agate_lump.png",
    })

end
