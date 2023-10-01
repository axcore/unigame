---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_garnierite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_garnierite.init()

    return {
        description = "Garnierite (as a mineral)",
    }

end

function unilib.pkg.mineral_garnierite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "garnierite",
        description = S("Garnierite"),

        hardness = 2,
        -- (Craft recipe provided by the "metal_nickel" package)
        metal_list = {"nickel"},
    })

    unilib.register_craftitem("unilib:mineral_garnierite_lump", "real_minerals:garnierite", mode, {
        -- From real_minerals:garnierite
        description = S("Garnierite Lump"),
        inventory_image = "unilib_mineral_garnierite_lump.png",
    })

end
