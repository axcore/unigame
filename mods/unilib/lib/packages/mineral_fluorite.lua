---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_fluorite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_fluorite.init()

    return {
        description = "Fluorite (as mineral)",
        optional = "metal_calcium",
    }

end

function unilib.pkg.mineral_fluorite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "fluorite",
        description = S("Fluorite"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_fluorite_lump", nil, mode, {
        -- Original to unilib
        description = S("Fluorite Lump"),
        inventory_image = "unilib_mineral_fluorite_lump.png",
    })
    if unilib.pkg_executed_table["metal_calcium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_calcium_chunk",
            recipe = "unilib:mineral_fluorite_lump",
        })

    end

end
