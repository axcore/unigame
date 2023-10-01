---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_jade = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_jade.init()

    return {
        description = "Jade (as a mineral)",
    }

end

function unilib.pkg.mineral_jade.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "jade",
        description = S("Jade"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_jade_lump", nil, mode, {
        -- Texture from AATO, jade.png. Original code
        description = S("Jade Lump"),
        inventory_image = "unilib_mineral_jade_lump.png",
    })

end
