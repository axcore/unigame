---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_barite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_barite.init()

    return {
        description = "Barite (as mineral)",
        optional = "metal_barium",
    }

end

function unilib.pkg.mineral_barite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "barite",
        description = S("Barite"),

        hardness = 2,
        metal_list = {"barium"},
    })

    unilib.register_craftitem("unilib:mineral_barite_lump", nil, mode, {
        -- Original to unilib
        description = S("Barite Lump"),
        inventory_image = "unilib_mineral_barite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_barium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_barium_chunk",
            recipe = "unilib:mineral_barite_lump",
        })

    end

end

