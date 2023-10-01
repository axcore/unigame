---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cryolite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cryolite.init()

    return {
        description = "Cryolite (as a mineral)",
    }

end

function unilib.pkg.mineral_cryolite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "cryolite",
        description = S("Cryolite"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_cryolite_lump", "real_minerals:cryolite", mode, {
        -- From real_minerals:cryolite
        description = S("Cryolite Lump"),
        inventory_image = "unilib_mineral_cryolite_lump.png",
    })

end
