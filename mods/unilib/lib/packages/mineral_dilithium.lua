---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_dilithium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_dilithium.init()

    return {
        description = "Dilithium (as a mineral)",
    }

end

function unilib.pkg.mineral_dilithium.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "dilithium",
        description = S("Dilithium"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_dilithium_lump", nil, mode, {
        -- Original to unilib
        description = S("Dilithium Lump"),
        inventory_image = "unilib_mineral_dilithium_lump.png",
    })

end
