---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cinnabar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cinnabar.init()

    return {
        description = "Cinnabar (as a mineral)",
        optional = "metal_mercury",
    }

end

function unilib.pkg.mineral_cinnabar.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "cinnabar",
        description = S("Cinnabar"),

        hardness = 1,
        metal_list = {"mercury"},
    })

    unilib.register_craftitem(
        -- From real_minerals:cinnabar
        "unilib:mineral_cinnabar_lump",
        "real_minerals:cinnabar",
        mode,
        {
            description = S("Cinnabar Lump"),
            inventory_image = "unilib_mineral_cinnabar_lump.png",
        }
    )
    if unilib.pkg_executed_table["metal_mercury"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_mercury_sample",
            recipe = "unilib:mineral_cinnabar_lump",
        })

    end

end
