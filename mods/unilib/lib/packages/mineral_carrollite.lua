---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carrollite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carrollite.init()

    return {
        description = "Carrollite (as mineral)",
        optional = "metal_cobalt",
    }

end

function unilib.pkg.mineral_carrollite.exec()

    local c_lump = "unilib:mineral_carrollite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "carrollite",
        description = S("Carrollite"),

        hardness = 3,
        metal_list = {"cobalt"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, carrollite.png). Original code
        description = S("Carrollite Lump"),
        inventory_image = "unilib_mineral_carrollite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_cobalt"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_cobalt_ingot",
            recipe = c_lump,
        })

    end

end
