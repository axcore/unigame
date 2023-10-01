---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_turquoise = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_turquoise.init()

    return {
        description = "Turquoise (as a mineral)",
    }

end

function unilib.pkg.mineral_turquoise.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "turquoise",
        description = S("Turquoise"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_turquoise_lump", nil, mode, {
        -- Texture from AATO, turquoise.png. Original code
        description = S("Turquoise Lump"),
        inventory_image = "unilib_mineral_turquoise_lump.png",
    })

end
