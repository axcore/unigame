---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_trona = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_trona.init()

    return {
        description = "Trona (as mineral)",
    }

end

function unilib.pkg.mineral_trona.exec()

    local c_lump = "unilib:mineral_trona_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "trona",
        description = S("Trona"),

        hardness = 1,
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = unilib.brackets(S("Trona Lump"), S("Soda Ash")),
        inventory_image = "unilib_mineral_trona_lump.png",
    })

end
