---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_thortveitite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_thortveitite.init()

    return {
        description = "Thortveitite (as mineral)",
        optional = "metal_scandium",
    }

end

function unilib.pkg.mineral_thortveitite.exec()

    local c_lump = "unilib:mineral_thortveitite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "thortveitite",
        description = S("Thortveitite"),

        hardness = 3,
        metal_list = {"scandium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, thortveitite.png). Original code
        description = S("Thortveitite Lump"),
        inventory_image = "unilib_mineral_thortveitite_lump.png",
    })
    if unilib.pkg_executed_table["metal_scandium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_scandium_ingot",
            recipe = c_lump,
        })

    end

end
