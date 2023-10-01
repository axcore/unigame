---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chalcopyrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chalcopyrite.init()

    return {
        description = "Chalcopyrite (as mineral)",
        optional = "metal_copper",
    }

end

function unilib.pkg.mineral_chalcopyrite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "chalcopyrite",
        description = S("Chalcopyrite"),

        hardness = 2,
        metal_list = {"copper"},
    })

    unilib.register_craftitem("unilib:mineral_chalcopyrite_lump", nil, mode, {
        -- Original to unilib
        description = S("Chalcopyrite Lump"),
        inventory_image = "unilib_mineral_chalcopyrite_lump.png",
    })
    if unilib.pkg_executed_table["metal_copper"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_copper_ingot",
            recipe = "unilib:mineral_chalcopyrite_lump",
        })

    end

end
