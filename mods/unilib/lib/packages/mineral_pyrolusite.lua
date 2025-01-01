---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pyrolusite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pyrolusite.init()

    return {
        description = "Pyrolusite (as mineral)",
        optional = "metal_manganese",
    }

end

function unilib.pkg.mineral_pyrolusite.exec()


    unilib.register_mineral({
        -- Original to unilib
        part_name = "pyrolusite",
        description = S("Pyrolusite"),

        hardness = 1,
        metal_list = {"manganese"},
    })

    unilib.register_craftitem("unilib:mineral_pyrolusite_lump", nil, mode, {
        -- Original to unilib
        description = S("Pyrolusite Lump"),
        inventory_image = "unilib_mineral_pyrolusite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_manganese"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_manganese_ingot",
            recipe = "unilib:mineral_pyrolusite_lump",
        })

    end

end
