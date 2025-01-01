---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_vanadinite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_vanadinite.init()

    return {
        description = "Vanadinite (as mineral)",
        optional = "metal_vanadium",
    }

end

function unilib.pkg.mineral_vanadinite.exec()

    local c_lump = "unilib:mineral_vanadinite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "vanadinite",
        description = S("Vanadinite"),

        hardness = 2,
        metal_list = {"vanadium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, vanadinite.png). Original code
        description = S("Vanadinite Lump"),
        inventory_image = "unilib_mineral_vanadinite_lump.png",
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
