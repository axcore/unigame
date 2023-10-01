---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_anglesite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_anglesite.init()

    return {
        description = "Anglesite (as mineral)",
        optional = "metal_lead",
    }

end

function unilib.pkg.mineral_anglesite.exec()

    local c_lump = "unilib:mineral_anglesite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "anglesite",
        description = S("Anglesite"),

        hardness = 1,
        metal_list = {"lead"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, anglesite.png). Original code
        description = S("Anglesite Lump"),
        inventory_image = "unilib_mineral_anglesite_lump.png",
    })
    if unilib.pkg_executed_table["metal_lead"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_lead_ingot",
            recipe = c_lump,
        })

    end

end
