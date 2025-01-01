---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_satinspar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_satinspar.init()

    return {
        description = "Satin spar (as a mineral)",
    }

end

function unilib.pkg.mineral_satinspar.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "satinspar",
        description = S("Satin spar"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_satinspar_lump", "real_minerals:satin_spar", mode, {
        -- From real_minerals:satin_spar
        description = S("Satin Spar Lump"),
        inventory_image = "unilib_mineral_satinspar_lump.png",
    })

end
