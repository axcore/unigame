---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sulphur_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sulphur_real.init()

    return {
        description = "Real sulphur (as a mineral)",
    }

end

function unilib.pkg.mineral_sulphur_real.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sulphur_real",
        description = S("Real Sulphur"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_sulphur_real_lump", "real_minerals:sulfur", mode, {
        -- From real_minerals:sulfur
        description = S("Real Sulphur Lump"),
        inventory_image = "unilib_mineral_sulphur_real_lump.png",
    })

end
