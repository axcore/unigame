---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chrysotile = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chrysotile.init()

    return {
        description = "Chrysotile (as mineral)",
    }

end

function unilib.pkg.mineral_chrysotile.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "chrysotile",
        description = S("Chrysotile"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_chrysotile_lump", nil, mode, {
        -- Original to unilib
        description = S("Chrysotile Lump"),
        inventory_image = "unilib_mineral_chrysotile_lump.png",
    })

end
