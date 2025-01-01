---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_nepheline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_nepheline.init()

    return {
        description = "Nepheline (as mineral)",
        optional = "metal_aluminium",
    }

end

function unilib.pkg.mineral_nepheline.exec()

    local c_lump = "unilib:mineral_nepheline_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "nepheline",
        description = S("Nepheline"),

        hardness = 3,
        metal_list = {"aluminium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, nepheline.png). Original code
        description = S("Nepheline Lump"),
        inventory_image = "unilib_mineral_nepheline_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_aluminium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_aluminium_ingot",
            recipe = c_lump,
        })

    end

end
