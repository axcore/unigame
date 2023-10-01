---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_celestine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_celestine.init()

    return {
        description = "Celestine (as mineral)",
        optional = "metal_strontium",
    }

end

function unilib.pkg.mineral_celestine.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "celestine",
        description = S("Celestine"),

        hardness = 3,
        metal_list = {"strontium"},
    })

    unilib.register_craftitem("unilib:mineral_celestine_lump", nil, mode, {
        -- Original to unilib
        description = S("Celestine Lump"),
        inventory_image = "unilib_mineral_celestine_lump.png",
    })
    if unilib.pkg_executed_table["metal_strontium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_strontium_chunk",
            recipe = "unilib:mineral_celestine_lump",
        })

    end

end
