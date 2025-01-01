---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_quartz_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_quartz_brown.init()

    return {
        description = "Brown quartz (as mineral)",
    }

end

function unilib.pkg.mineral_quartz_brown.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "quartz_brown",
        description = S("Brown Quartz"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_quartz_brown_lump", nil, mode, {
        -- Original to unilib
        description = S("Brown Quartz Lump"),
        inventory_image = "unilib_mineral_quartz_brown_lump.png",
    })

end
