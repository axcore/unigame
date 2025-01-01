---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_zeolite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_zeolite.init()

    return {
        description = "Zeolite (as mineral)",
    }

end

function unilib.pkg.mineral_zeolite.exec()

    local c_lump = "unilib:mineral_zeolite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "zeolite",
        description = S("Zeolite"),

        hardness = 2,
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Zeolite Lump"),
        inventory_image = "unilib_mineral_zeolite_lump.png",
    })

end
