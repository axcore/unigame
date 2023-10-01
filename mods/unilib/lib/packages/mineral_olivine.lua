---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_olivine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_olivine.init()

    return {
        description = "Olivine (as a mineral)",
    }

end

function unilib.pkg.mineral_olivine.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "olivine",
        description = S("Olivine"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_olivine_lump", "real_minerals:olivine", mode, {
        -- From real_minerals:olivine
        description = S("Olivine Lump"),
        inventory_image = "unilib_mineral_olivine_lump.png",
    })

end
