---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_amethyst_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_amethyst_dark.init()

    return {
        description = "Dark amethyst (as a mineral)",
    }

end

function unilib.pkg.mineral_amethyst_dark.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "amethyst_dark",
        description = S("Dark Amethyst"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_amethyst_dark_lump", nil, mode, {
        -- Texture from AATO, amethyst.png. Original code
        description = S("Dark Amethyst Lump"),
        inventory_image = "unilib_mineral_amethyst_dark_lump.png",
    })

end
