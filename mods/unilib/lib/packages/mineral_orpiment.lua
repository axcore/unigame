---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_orpiment = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_orpiment.init()

    return {
        description = "Orpiment (as mineral)",
        optional = "metal_arsenic",
    }

end

function unilib.pkg.mineral_orpiment.exec()

    local c_lump = "unilib:mineral_orpiment_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "orpiment",
        description = S("Orpiment"),

        hardness = 1,
        metal_list = {"arsenic"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, orpiment.png). Original code
        description = S("Orpiment Lump"),
        inventory_image = "unilib_mineral_orpiment_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_arsenic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_arsenic_sample",
            recipe = c_lump,
        })

    end

end
