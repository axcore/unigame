---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_heliotrope = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_heliotrope.init()

    return {
        description = "Heliotrope (as a mineral)",
    }

end

function unilib.pkg.mineral_heliotrope.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "heliotrope",
        description = S("Heliotrope"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_heliotrope_lump", nil, mode, {
        -- Texture from AATO, heliotrope.png. Original code
        description = S("Heliotrope Lump"),
        inventory_image = "unilib_mineral_heliotrope_lump.png",
    })

end
