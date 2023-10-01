---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_saltpetre = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_saltpetre.init()

    return {
        description = "Saltpetre (as a mineral)",
    }

end

function unilib.pkg.mineral_saltpetre.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "saltpetre",
        description = S("Saltpetre"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_saltpetre_lump", "real_minerals:saltpeter", mode, {
        -- From real_minerals:saltpetre
        description = unilib.brackets(S("Saltpetre Lump"), S("Nitre")),
        inventory_image = "unilib_mineral_saltpetre_lump.png",
    })

end
