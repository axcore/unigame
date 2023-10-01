---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hollandite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hollandite.init()

    return {
        description = "Hollandite (as mineral)",
        optional = "metal_manganese",
    }

end

function unilib.pkg.mineral_hollandite.exec()

    local c_lump = "unilib:mineral_hollandite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "hollandite",
        description = S("Hollandite"),

        hardness = 3,
        metal_list = {"manganese"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, hollandite.png). Original code
        description = S("Hollandite Lump"),
        inventory_image = "unilib_mineral_hollandite_lump.png",
    })
    if unilib.pkg_executed_table["metal_manganese"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_manganese_ingot",
            recipe = c_lump,
        })

    end

end
