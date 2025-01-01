---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bismuthinite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bismuthinite.init()

    return {
        description = "Bismuthinite (as a mineral)",
    }

end

function unilib.pkg.mineral_bismuthinite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "bismuthinite",
        description = S("Bismuthinite"),

        hardness = 1,
        -- (Craft recipe provided by the "metal_bismuth" package)
        metal_list = {"bismuth"},
    })

    unilib.register_craftitem(
        -- From real_minerals:bismuthinite
        "unilib:mineral_bismuthinite_lump",
        "real_minerals:bismuthinite",
        mode,
        {
            description = S("Bismuthinite Lump"),
            inventory_image = "unilib_mineral_bismuthinite_lump.png",
        }
    )

end
