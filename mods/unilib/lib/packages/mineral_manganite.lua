---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_manganite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_manganite.init()

    return {
        description = "Manganite (as mineral)",
        optional = "metal_manganese",
    }

end

function unilib.pkg.mineral_manganite.exec()

    local c_lump = "unilib:mineral_manganite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "manganite",
        description = S("Manganite"),

        hardness = 2,
        metal_list = {"manganese"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, manganite.png). Original code
        description = S("Manganite Lump"),
        inventory_image = "unilib_mineral_manganite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_manganese"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_manganese_ingot",
            recipe = c_lump,
        })

    end

end
