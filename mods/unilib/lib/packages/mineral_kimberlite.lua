---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kimberlite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kimberlite.init()

    return {
        description = "Kimberlite (as a mineral)",
    }

end

function unilib.pkg.mineral_kimberlite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "kimberlite",
        description = S("Kimberlite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_kimberlite_lump", "real_minerals:kimberlite", mode, {
        -- From real_minerals:kimberlite
        description = S("Kimberlite Lump"),
        inventory_image = "unilib_mineral_kimberlite_lump.png",
    })

end
