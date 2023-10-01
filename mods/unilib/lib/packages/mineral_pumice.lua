---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pumice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pumice.init()

    return {
        description = "Pumice (as mineral)",
    }

end

function unilib.pkg.mineral_pumice.exec()

    local c_lump = "unilib:mineral_pumice_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pumice",
        description = S("Pumice"),

        hardness = 3,
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Pumice Lump"),
        inventory_image = "unilib_mineral_pumice_lump.png",
    })

end
