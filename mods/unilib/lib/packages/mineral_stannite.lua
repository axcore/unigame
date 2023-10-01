---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_stannite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_stannite.init()

    return {
        description = "Stannite (as mineral)",
        optional = "metal_tin",
    }

end

function unilib.pkg.mineral_stannite.exec()

    local c_lump = "unilib:mineral_stannite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "stannite",
        description = S("Stannite"),

        hardness = 2,
        metal_list = {"tin"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, stannite.png). Original code
        description = S("Stannite Lump"),
        inventory_image = "unilib_mineral_stannite_lump.png",
    })
    if unilib.pkg_executed_table["metal_tin"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_tin_ingot",
            recipe = c_lump,
        })

    end

end
