---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hausmannite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hausmannite.init()

    return {
        description = "Hausmannite (as mineral)",
        optional = "metal_manganese",
    }

end

function unilib.pkg.mineral_hausmannite.exec()

    local c_lump = "unilib:mineral_hausmannite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "hausmannite",
        description = S("Hausmannite"),

        hardness = 3,
        metal_list = {"manganese"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, hausmannite.png). Original code
        description = S("Hausmannite Lump"),
        inventory_image = "unilib_mineral_hausmannite_lump.png",
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
