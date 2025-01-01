---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_magnesite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_magnesite.init()

    return {
        description = "Magnesite (as mineral)",
        optional = "metal_magnesium",
    }

end

function unilib.pkg.mineral_magnesite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "magnesite",
        description = S("Magnesite"),

        hardness = 2,
        metal_list = {"magnesium"},
    })

    unilib.register_craftitem("unilib:mineral_magnesite_lump", nil, mode, {
        -- Original to unilib
        description = S("Magnesite Lump"),
        inventory_image = "unilib_mineral_magnesite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_magnesium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_magnesium_ingot",
            recipe = "unilib:mineral_magnesite_lump",
        })

    end

end
