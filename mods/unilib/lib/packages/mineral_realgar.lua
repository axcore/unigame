---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_realgar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_realgar.init()

    return {
        description = "Realgar (as mineral)",
        optional = "metal_arsenic",
    }

end

function unilib.pkg.mineral_realgar.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "realgar",
        description = S("Realgar"),

        hardness = 1,
        metal_list = {"arsenic"},
    })

    unilib.register_craftitem("unilib:mineral_realgar_lump", nil, mode, {
        -- Original to unilib
        description = S("Realgar Lump"),
        inventory_image = "unilib_mineral_realgar_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_arsenic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_arsenic_sample",
            recipe = "unilib:mineral_realgar_lump",
        })

    end

end
