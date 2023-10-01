---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_nitratine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_nitratine.init()

    return {
        description = "Nitratine (as mineral)",
        optional = "metal_sodium",
    }

end

function unilib.pkg.mineral_nitratine.exec()

    local c_lump = "unilib:mineral_nitratine_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "nitratine",
        description = S("Nitratine"),

        hardness = 1,
        metal_list = {"sodium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, nitratine.png). Original code
        description = S("Nitratine Lump"),
        inventory_image = "unilib_mineral_nitratine_lump.png",
    })
    if unilib.pkg_executed_table["metal_sodium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_sodium_chunk",
            recipe = c_lump,
        })

    end

end
