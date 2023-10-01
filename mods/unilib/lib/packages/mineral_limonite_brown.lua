---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_limonite_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_limonite_brown.init()

    return {
        description = "Brown Limonite (as mineral)",
        optional = {"metal_iron_pig", "metal_iron_wrought"},
    }

end

function unilib.pkg.mineral_limonite_brown.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "limonite_brown",
        description = S("Brown Limonite"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_limonite_brown_lump", nil, mode, {
        -- Original to unilib
        description = S("Brown Limonite Lump"),
        inventory_image = "unilib_mineral_limonite_brown_lump.png",
    })
    if unilib.pkg_executed_table["metal_iron_pig"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = "unilib:mineral_limonite_brown_lump",
        })

        unilib.update_mineral({
            part_name = "limonite_brown",
            metal_list = {"iron_pig"},
        })

    elseif unilib.pkg_executed_table["metal_iron_wrought"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_iron_wrought_ingot",
            recipe = "unilib:mineral_limonite_yellow_lump",
        })

        unilib.update_mineral({
            part_name = "limonite_brown",
            metal_list = {"iron_wrought"},
        })

    end

end
