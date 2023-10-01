---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_polyhalite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_polyhalite.init()

    return {
        description = "Polyhalite (as mineral)",
        optional = "metal_potassium",
    }

end

function unilib.pkg.mineral_polyhalite.exec()

    local c_lump = "unilib:mineral_polyhalite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "polyhalite",
        description = S("Polyhalite"),

        hardness = 2,
        metal_list = {"potassium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, polyhalite.png). Original code
        description = S("Polyhalite Lump"),
        inventory_image = "unilib_mineral_polyhalite_lump.png",
    })
    if unilib.pkg_executed_table["metal_potassium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_potassium_chunk",
            recipe = c_lump,
        })

    end

end
