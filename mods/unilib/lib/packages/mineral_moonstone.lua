---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_moonstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_moonstone.init()

    return {
        description = "Moonstone (as a mineral)",
    }

end

function unilib.pkg.mineral_moonstone.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "moonstone",
        description = S("Moonstone"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_moonstone_lump", nil, mode, {
        -- Texture from AATO, moonstone.png. Original code
        description = S("Moonstone Lump"),
        inventory_image = "unilib_mineral_moonstone_lump.png",
    })

end
