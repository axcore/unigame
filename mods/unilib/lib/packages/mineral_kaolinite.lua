---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kaolinite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kaolinite.init()

    return {
        description = "Kaolinite (as a mineral)",
    }

end

function unilib.pkg.mineral_kaolinite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "kaolinite",
        description = S("Kaolinite"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_kaolinite_lump", "real_minerals:kaolinite", mode, {
        -- From real_minerals:kaolinite
        description = S("Kaolinite Lump"),
        inventory_image = "unilib_mineral_kaolinite_lump.png",
    })

end
