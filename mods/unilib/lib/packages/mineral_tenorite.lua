---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_tenorite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_tenorite.init()

    return {
        description = "Tenorite (as a mineral)",
    }

end

function unilib.pkg.mineral_tenorite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "tenorite",
        description = S("Tenorite"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_tenorite_lump", "real_minerals:tenorite", mode, {
        -- From real_minerals:tenorite
        description = S("Tenorite Lump"),
        inventory_image = "unilib_mineral_tenorite_lump.png",
    })

end
