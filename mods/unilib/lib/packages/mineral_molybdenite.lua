---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_molybdenite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_molybdenite.init()

    return {
        description = "Molybdenite (as mineral)",
        optional = "metal_molybdenum",
    }

end

function unilib.pkg.mineral_molybdenite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "molybdenite",
        description = S("Molybdenite"),

        hardness = 1,
        metal_list = {"molybdenum"},
    })

    unilib.register_craftitem("unilib:mineral_molybdenite_lump", nil, mode, {
        -- Original to unilib
        description = S("Molybdenite Lump"),
        inventory_image = "unilib_mineral_molybdenite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_molybdenum"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_molybdenum_ingot",
            recipe = "unilib:mineral_molybdenite_lump",
        })

    end

end
