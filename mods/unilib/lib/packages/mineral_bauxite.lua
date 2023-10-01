---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bauxite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bauxite.init()

    return {
        description = "Bauxite (as a mineral)",
    }

end

function unilib.pkg.mineral_bauxite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "bauxite",
        description = S("Bauxite"),

        hardness = 1,
        -- (Craft recipe provided by the "metal_aluminium" package)
        metal_list = {"aluminium"},
    })

    unilib.register_craftitem(
        -- From real_minerals:bauxite
        "unilib:mineral_bauxite_lump",
        "real_minerals:bauxite",
        mode,
        {
            description = S("Bauxite Lump"),
            inventory_image = "unilib_mineral_bauxite_lump.png",
        }
    )

end
