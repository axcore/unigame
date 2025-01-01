---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_perlite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_perlite.init()

    return {
        description = "Perlite (as mineral)",
    }

end

function unilib.pkg.mineral_perlite.exec()

    local c_lump = "unilib:mineral_perlite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "perlite",
        description = S("Perlite"),

        hardness = 3,
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Perlite Lump"),
        inventory_image = "unilib_mineral_perlite_lump.png",
    })

end
