---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carnotite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carnotite.init()

    return {
        description = "Carnotite (as mineral)",
        optional = "metal_uranium",
    }

end

function unilib.pkg.mineral_carnotite.exec()

    local c_lump = "unilib:mineral_carnotite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "carnotite",
        description = S("Carnotite"),

        hardness = 1,
        metal_list = {"uranium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, carnotite.png). Original code
        description = S("Carnotite Lump"),
        inventory_image = "unilib_mineral_carnotite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_uranium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_uranium_ingot",
            recipe = c_lump,
        })

    end

end
