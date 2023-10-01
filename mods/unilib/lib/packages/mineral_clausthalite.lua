---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_clausthalite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_clausthalite.init()

    return {
        description = "Clausthalite (as mineral)",
        optional = "substance_selenium",
    }

end

function unilib.pkg.mineral_clausthalite.exec()

    local c_lump = "unilib:mineral_clausthalite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "clausthalite",
        description = S("Clausthalite"),

        hardness = 1,
        non_metal_list = {"selenium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, clausthalite.png). Original code
        description = S("Clausthalite Lump"),
        inventory_image = "unilib_mineral_clausthalite_lump.png",
    })
    if unilib.pkg_executed_table["substance_selenium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:substance_selenium_chunk",
            recipe = c_lump,
        })

    end

end
