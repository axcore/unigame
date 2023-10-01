---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_topaz = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_topaz.init()

    return {
        description = "Topaz (as a mineral)",
    }

end

function unilib.pkg.mineral_topaz.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "topaz",
        description = S("Topaz"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_topaz_lump", nil, mode, {
        -- Texture from AATO, topaz.png. Original code
        description = S("Topaz Lump"),
        inventory_image = "unilib_mineral_topaz_lump.png",
    })

end
