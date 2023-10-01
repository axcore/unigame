---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_wood_petrified = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_wood_petrified.init()

    return {
        description = "Petrified wood (as a mineral)",
    }

end

function unilib.pkg.mineral_wood_petrified.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "wood_petrified",
        description = S("Petrified Wood"),

        hardness = 1,
    })

    unilib.register_craftitem(
        -- From real_minerals:petrified_wood
        "unilib:mineral_wood_petrified_lump",
        "real_minerals:petrified_wood",
        mode,
        {
            description = S("Petrified Wood Lump"),
            inventory_image = "unilib_mineral_wood_petrified_lump.png",
        }
    )

end
