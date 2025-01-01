---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_cerussite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_cerussite.init()

    return {
        description = "Cerussite (as mineral)",
        optional = "metal_lead",
    }

end

function unilib.pkg.mineral_cerussite.exec()

    local c_lump = "unilib:mineral_cerussite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "cerussite",
        description = S("Cerussite"),

        hardness = 2,
        metal_list = {"lead"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, cerussite.png). Original code
        description = S("Cerussite Lump"),
        inventory_image = "unilib_mineral_cerussite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_lead"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_lead_ingot",
            recipe = c_lump,
        })

    end

end
