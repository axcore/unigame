---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_pollucite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_pollucite.init()

    return {
        description = "Pollucite (as mineral)",
        optional = "metal_caesium",
    }

end

function unilib.pkg.mineral_pollucite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "pollucite",
        description = S("Pollucite"),

        hardness = 3,
        metal_list = {"caesium"},
    })

    unilib.register_craftitem("unilib:mineral_pollucite_lump", nil, mode, {
        -- Original to unilib
        description = S("Pollucite Lump"),
        inventory_image = "unilib_mineral_pollucite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_caesium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_caesium_sample",
            recipe = "unilib:mineral_pollucite_lump",
        })

    end

end
