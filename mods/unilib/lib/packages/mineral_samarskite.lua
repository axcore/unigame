---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_samarskite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_samarskite.init()

    return {
        description = "Samarskite (as mineral)",
        optional = "metal_yttrium",
    }

end

function unilib.pkg.mineral_samarskite.exec()

    local c_lump = "unilib:mineral_samarskite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "samarskite",
        description = S("Samarskite"),

        hardness = 3,
        metal_list = {"yttrium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, samarskite_y.png). Original code
        description = S("Samarskite Lump"),
        inventory_image = "unilib_mineral_samarskite_lump.png",
    })
    if unilib.pkg_executed_table["metal_yttrium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_yttrium_chunk",
            recipe = c_lump,
        })

    end

end
