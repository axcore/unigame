---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_leucite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_leucite.init()

    return {
        description = "Leucite (as mineral)",
        optional = "metal_aluminium",
    }

end

function unilib.pkg.mineral_leucite.exec()

    local c_lump = "unilib:mineral_leucite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "leucite",
        description = S("Leucite"),

        hardness = 3,
        metal_list = {"aluminium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, leucite.png). Original code
        description = S("Leucite Lump"),
        inventory_image = "unilib_mineral_leucite_lump.png",
    })
    if unilib.pkg_executed_table["metal_aluminium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_aluminium_ingot",
            recipe = c_lump,
        })

    end

end
