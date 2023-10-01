---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_selenite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_selenite.init()

    return {
        description = "Selenite (as a mineral)",
    }

end

function unilib.pkg.mineral_selenite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "selenite",
        description = S("Selenite"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_selenite_lump", "real_minerals:selenite", mode, {
        -- From real_minerals:selenite
        description = S("Selenite Lump"),
        inventory_image = "unilib_mineral_selenite_lump.png",
    })

end
