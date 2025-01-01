---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_ilmenite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_ilmenite.init()

    return {
        description = "Ilmenite (as mineral)",
        optional = "metal_titanium",
    }

end

function unilib.pkg.mineral_ilmenite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "ilmenite",
        description = S("Ilmenite"),

        hardness = 3,
        metal_list = {"titanium"},
    })

    unilib.register_craftitem("unilib:mineral_ilmenite_lump", nil, mode, {
        -- Original to unilib
        description = S("Ilmenite Lump"),
        inventory_image = "unilib_mineral_ilmenite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_titanium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_titanium_ingot",
            recipe = "unilib:mineral_ilmenite_lump",
        })

    end

end
