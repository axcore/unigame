---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_apatite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_apatite.init()

    return {
        description = "Apatite (as mineral)",
    }

end

function unilib.pkg.mineral_apatite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "apatite",
        description = S("Apatite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_apatite_lump", nil, mode, {
        -- Original to unilib
        description = S("Apatite Lump"),
        inventory_image = "unilib_mineral_apatite_lump.png",
    })

end
