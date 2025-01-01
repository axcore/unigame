---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_freibergite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_freibergite.init()

    return {
        description = "Freibergite (as mineral)",
        optional = "metal_silver",
    }

end

function unilib.pkg.mineral_freibergite.exec()

    local c_lump = "unilib:mineral_freibergite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "freibergite",
        description = S("Freibergite"),

        hardness = 2,
        metal_list = {"silver"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, freibergite.png). Original code
        description = S("Freibergite Lump"),
        inventory_image = "unilib_mineral_freibergite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_silver"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_silver_ingot",
            recipe = c_lump,
        })

    end

end
