---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hauyne = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hauyne.init()

    return {
        description = "Hauyne (as a mineral)",
    }

end

function unilib.pkg.mineral_hauyne.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "hauyne",
        description = S("Hauyne"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_hauyne_lump", nil, mode, {
        -- Texture from AATO, hauyne.png. Original code
        description = S("Hauyne Lump"),
        inventory_image = "unilib_mineral_hauyne_lump.png",
    })

end
