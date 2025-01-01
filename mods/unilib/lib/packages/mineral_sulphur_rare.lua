---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sulphur_rare = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sulphur_rare.init()

    return {
        description = "Rare sulphur (as a mineral)",
    }

end

function unilib.pkg.mineral_sulphur_rare.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sulphur_rare",
        description = S("Rare Sulphur"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_sulphur_rare_lump", "real_minerals:sulfur", mode, {
        -- From real_minerals:sulfur
        description = S("Rare Sulphur Lump"),
        inventory_image = "unilib_mineral_sulphur_rare_lump.png",
    })

end
