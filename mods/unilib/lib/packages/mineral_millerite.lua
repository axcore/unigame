---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_millerite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_millerite.init()

    return {
        description = "Millerite (as mineral)",
        optional = "metal_nickel",
    }

end

function unilib.pkg.mineral_millerite.exec()

    local c_lump = "unilib:mineral_millerite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "millerite",
        description = S("Millerite"),

        hardness = 2,
        metal_list = {"nickel"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, millerite.png). Original code
        description = S("Millerite Lump"),
        inventory_image = "unilib_mineral_millerite_lump.png",
    })
    if unilib.pkg_executed_table["metal_nickel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_nickel_ingot",
            recipe = c_lump,
        })

    end

end
