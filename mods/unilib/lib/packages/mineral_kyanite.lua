---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kyanite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kyanite.init()

    return {
        description = "Kyanite (as mineral)",
    }

end

function unilib.pkg.mineral_kyanite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "kyanite",
        description = S("Kyanite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_kyanite_lump", nil, mode, {
        -- Original to unilib
        description = S("Kyanite Lump"),
        inventory_image = "unilib_mineral_kyanite_lump.png",
    })

end
