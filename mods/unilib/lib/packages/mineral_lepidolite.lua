---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_lepidolite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_lepidolite.init()

    return {
        description = "Lepidolite (as mineral)",
        optional = "metal_lithium",
    }

end

function unilib.pkg.mineral_lepidolite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "lepidolite",
        description = S("Lepidolite"),

        hardness = 2,
        metal_list = {"lithium"},
    })

    unilib.register_craftitem("unilib:mineral_lepidolite_lump", nil, mode, {
        -- Original to unilib
        description = S("Lepidolite Lump"),
        inventory_image = "unilib_mineral_lepidolite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_lithium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_lithium_chunk",
            recipe = "unilib:mineral_lepidolite_lump",
        })

    end

end
