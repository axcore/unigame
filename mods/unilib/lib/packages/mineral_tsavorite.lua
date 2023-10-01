---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tsavorite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tsavorite.init()

    return {
        description = "Tsavorite (as a mineral)",
    }

end

function unilib.pkg.mineral_tsavorite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tsavorite",
        description = S("Tsavorite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_tsavorite_lump", nil, mode, {
        -- Texture from AATO, tsavorite.png. Original code
        description = S("Tsavorite Lump"),
        inventory_image = "unilib_mineral_tsavorite_lump.png",
    })

end
