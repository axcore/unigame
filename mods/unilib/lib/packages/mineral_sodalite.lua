---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sodalite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sodalite.init()

    return {
        description = "Sodalite (as mineral)",
    }

end

function unilib.pkg.mineral_sodalite.exec()

    local c_lump = "unilib:mineral_sodalite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sodalite",
        description = S("Sodalite"),

        hardness = 3,
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Sodalite Lump"),
        inventory_image = "unilib_mineral_sodalite_lump.png",
    })

end
