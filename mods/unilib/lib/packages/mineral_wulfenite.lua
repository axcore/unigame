---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_wulfenite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_wulfenite.init()

    return {
        description = "Wulfenite (as mineral)",
        optional = "metal_molybdenum",
    }

end

function unilib.pkg.mineral_wulfenite.exec()

    local c_lump = "unilib:mineral_wulfenite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "wulfenite",
        description = S("Wulfenite"),

        hardness = 1,
        metal_list = {"molybdenum"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, wulfenite.png). Original code
        description = S("Wulfenite Lump"),
        inventory_image = "unilib_mineral_wulfenite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_molybdenum"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_molybdenum_ingot",
            recipe = c_lump,
        })

    end

end
