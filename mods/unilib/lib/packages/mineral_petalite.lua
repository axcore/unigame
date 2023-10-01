---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_petalite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_petalite.init()

    return {
        description = "Petalite (as mineral)",
        optional = "metal_lithium",
    }

end

function unilib.pkg.mineral_petalite.exec()

    local c_lump = "unilib:mineral_petalite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "petalite",
        description = S("Petalite"),

        hardness = 3,
        metal_list = {"lithium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, petalite.png). Original code
        description = S("Petalite Lump"),
        inventory_image = "unilib_mineral_petalite_lump.png",
    })
    if unilib.pkg_executed_table["metal_lithium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_lithium_chunk",
            recipe = c_lump,
        })

    end

end
