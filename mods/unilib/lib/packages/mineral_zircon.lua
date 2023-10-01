---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_zircon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_zircon.init()

    return {
        description = "Zircon (as mineral)",
        optional = "metal_zirconium",
    }

end

function unilib.pkg.mineral_zircon.exec()

    local c_lump = "unilib:mineral_zircon_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "zircon",
        description = S("Zircon"),

        hardness = 3,
        metal_list = {"zirconium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, zircon.png). Original code
        description = S("Zircon Lump"),
        inventory_image = "unilib_mineral_zircon_lump.png",
    })
    if unilib.pkg_executed_table["metal_zirconium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_zirconium_ingot",
            recipe = c_lump,
        })

    end

end
