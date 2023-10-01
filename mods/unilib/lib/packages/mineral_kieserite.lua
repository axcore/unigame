---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_kieserite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_kieserite.init()

    return {
        description = "Kieserite (as mineral)",
        optional = "metal_magnesium",
    }

end

function unilib.pkg.mineral_kieserite.exec()

    local c_lump = "unilib:mineral_kieserite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "kieserite",
        description = S("Kieserite"),

        hardness = 2,
        metal_list = {"magnesium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, kieserite.png). Original code
        description = S("Kieserite Lump"),
        inventory_image = "unilib_mineral_kieserite_lump.png",
    })
    if unilib.pkg_executed_table["metal_magnesium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_magnesium_ingot",
            recipe = c_lump,
        })

    end

end
