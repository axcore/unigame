---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tanzanite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tanzanite.init()

    return {
        description = "Tanzanite (as a mineral)",
    }

end

function unilib.pkg.mineral_tanzanite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tanzanite",
        description = S("Tanzanite"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_tanzanite_lump", nil, mode, {
        -- Texture from AATO, tanzanite.png. Original code
        description = S("Tanzanite Lump"),
        inventory_image = "unilib_mineral_tanzanite_lump.png",
    })

end
