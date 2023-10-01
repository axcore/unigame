---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_germanite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_germanite.init()

    return {
        description = "Germanite (as mineral)",
        optional = "metal_germanium",
    }

end

function unilib.pkg.mineral_germanite.exec()

    local c_lump = "unilib:mineral_germanite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "germanite",
        description = S("Germanite"),

        hardness = 2,
        metal_list = {"germanium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, germanite.png). Original code
        description = S("Germanite Lump"),
        inventory_image = "unilib_mineral_germanite_lump.png",
    })
    if unilib.pkg_executed_table["metal_germanium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_germanium_ingot",
            recipe = c_lump,
        })

    end

end
