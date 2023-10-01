---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_onyx = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_onyx.init()

    return {
        description = "Onyx (as a mineral)",
    }

end

function unilib.pkg.mineral_onyx.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "onyx",
        description = S("Onyx"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_onyx_lump", nil, mode, {
        -- Texture from AATO, onyx.png. Original code
        description = S("Onyx Lump"),
        inventory_image = "unilib_mineral_onyx_lump.png",
    })

end
