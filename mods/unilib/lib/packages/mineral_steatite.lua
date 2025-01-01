---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_steatite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_steatite.init()

    return {
        description = "Steatite (as mineral)",
    }

end

function unilib.pkg.mineral_steatite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "steatite",
        description = S("Steatite"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_steatite_lump", nil, mode, {
        -- Original to unilib
        description = S("Steatite Lump"),
        inventory_image = "unilib_mineral_steatite_lump.png",
    })

end
