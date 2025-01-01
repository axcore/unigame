---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_argutite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_argutite.init()

    return {
        description = "Argutite (as mineral)",
        optional = "metal_germanium",
    }

end

function unilib.pkg.mineral_argutite.exec()

    local c_lump = "unilib:mineral_argutite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "argutite",
        description = S("Argutite"),

        hardness = 3,
        metal_list = {"germanium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, argutite.png). Original code
        description = S("Argutite Lump"),
        inventory_image = "unilib_mineral_argutite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_germanium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_germanium_ingot",
            recipe = c_lump,
        })

    end

end
