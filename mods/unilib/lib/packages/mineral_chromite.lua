---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chromite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chromite.init()

    return {
        description = "Chromite (as mineral)",
        optional = "metal_chromium",
    }

end

function unilib.pkg.mineral_chromite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "chromite",
        description = S("Chromite"),

        hardness = 3,
        metal_list = {"chromium"},
    })

    unilib.register_craftitem("unilib:mineral_chromite_lump", nil, mode, {
        -- Original to unilib
        description = S("Chromite Lump"),
        inventory_image = "unilib_mineral_chromite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_chromium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_chromium_ingot",
            recipe = "unilib:mineral_chromite_lump",
        })

    end

end
