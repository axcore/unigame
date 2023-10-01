---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pyrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pyrite.init()

    return {
        description = "Pyrite (as mineral)",
        optional = "metal_iron_pig",
    }

end

function unilib.pkg.mineral_pyrite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pyrite",
        description = S("Pyrite"),

        hardness = 3,
        metal_list = {"iron_pig"},
    })

    unilib.register_craftitem("unilib:mineral_pyrite_lump", nil, mode, {
        -- Original to unilib
        description = S("Pyrite Lump"),
        inventory_image = "unilib_mineral_pyrite_lump.png",
    })
    if unilib.pkg_executed_table["metal_iron_pig"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = "unilib:mineral_pyrite_lump",
        })

    end

end
