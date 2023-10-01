---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_serpentinite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_serpentinite.init()

    return {
        description = "Serpentinite (as a mineral)",
    }

end

function unilib.pkg.mineral_serpentinite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "serpentinite",
        description = S("Serpentinite"),

        hardness = 1,
    })

    unilib.register_craftitem(
        -- From real_minerals:serpentine
        "unilib:mineral_serpentinite_lump",
        "real_minerals:serpentine",
        mode,
        {
            description = S("Serpentinite Lump"),
            inventory_image = "unilib_mineral_serpentinite_lump.png",
        }
    )

end
