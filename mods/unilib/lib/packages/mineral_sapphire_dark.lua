---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sapphire_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sapphire_dark.init()

    return {
        description = "Dark sapphire (as a mineral)",
    }

end

function unilib.pkg.mineral_sapphire_dark.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sapphire_dark",
        description = S("Dark Sapphire"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_sapphire_dark_lump", nil, mode, {
        -- Texture from AATO, sapphire.png. Original code
        description = S("Dark Sapphire Lump"),
        inventory_image = "unilib_mineral_sapphire_dark_lump.png",
    })

end
