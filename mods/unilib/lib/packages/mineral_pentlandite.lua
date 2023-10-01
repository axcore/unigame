---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pentlandite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pentlandite.init()

    return {
        description = "Pentlandite (as mineral)",
        optional = "metal_nickel",
    }

end

function unilib.pkg.mineral_pentlandite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pentlandite",
        description = S("Pentlandite"),

        hardness = 2,
        metal_list = {"nickel"},
    })

    unilib.register_craftitem("unilib:mineral_pentlandite_lump", nil, mode, {
        -- Original to unilib
        description = S("Pentlandite Lump"),
        inventory_image = "unilib_mineral_pentlandite_lump.png",
    })
    if unilib.pkg_executed_table["metal_nickel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_nickel_ingot",
            recipe = "unilib:mineral_pentlandite_lump",
        })

    end

end
