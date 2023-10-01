---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_bastnasite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_bastnasite.init()

    return {
        description = "Bastnasite (as mineral)",
        optional = "metal_rhenium",
    }

end

function unilib.pkg.mineral_bastnasite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "bastnasite",
        description = S("Bastnasite"),

        hardness = 2,
        metal_list = {"rhenium"},
    })

    unilib.register_craftitem("unilib:mineral_bastnasite_lump", nil, mode, {
        -- Original to unilib
        description = S("Bastnasite Lump"),
        inventory_image = "unilib_mineral_bastnasite_lump.png",
    })
    if unilib.pkg_executed_table["metal_rhenium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_rhenium_ingot",
            recipe = "unilib:mineral_bastnasite_sample",
        })

    end

end
