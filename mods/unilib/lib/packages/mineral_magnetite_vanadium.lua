---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_magnetite_vanadium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_magnetite_vanadium.init()

    return {
        description = "Vanadium Magnetite (as mineral)",
        optional = "metal_iron_pig",
    }

end

function unilib.pkg.mineral_magnetite_vanadium.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "magnetite_vanadium",
        description = S("Vanadium Magnetite"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_magnetite_vanadium_lump", nil, mode, {
        -- Original to unilib
        description = S("Vanadium Magnetite Lump"),
        inventory_image = "unilib_mineral_magnetite_vanadium_lump.png",
    })
    if unilib.pkg_executed_table["metal_iron_pig"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = "unilib:mineral_magnetite_vanadium_lump",
        })

    end

end
