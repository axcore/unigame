---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_nickeline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_nickeline.init()

    return {
        description = "Nickeline (as mineral)",
        optional = "metal_nickel",
    }

end

function unilib.pkg.mineral_nickeline.exec()

    local c_lump = "unilib:mineral_nickeline_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "nickeline",
        description = S("Nickeline"),

        hardness = 3,
        metal_list = {"nickel"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, nickeline.png). Original code
        description = S("Nickeline Lump"),
        inventory_image = "unilib_mineral_nickeline_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_nickel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_nickel_ingot",
            recipe = c_lump,
        })

    end

end
