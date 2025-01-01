---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_descloizite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_descloizite.init()

    return {
        description = "Descloizite (as mineral)",
        optional = "metal_vanadium",
    }

end

function unilib.pkg.mineral_descloizite.exec()

    local c_lump = "unilib:mineral_descloizite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "descloizite",
        description = S("Descloizite"),

        hardness = 2,
        metal_list = {"vanadium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, descloizite.png). Original code
        description = S("Descloizite Lump"),
        inventory_image = "unilib_mineral_descloizite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_vanadium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_vanadium_ingot",
            recipe = c_lump,
        })

    end

end
