---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_lazurite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_lazurite.init()

    return {
        description = "Lazurite (as a mineral)",
    }

end

function unilib.pkg.mineral_lazurite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "lazurite",
        description = S("Lazurite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_lazurite_lump", "real_minerals:lazurite", mode, {
        -- From real_minerals:lazurite
        description = S("Lazurite Lump"),
        inventory_image = "unilib_mineral_lazurite_lump.png",
    })

end
