---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_greenockite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_greenockite.init()

    return {
        description = "Greenockite (as mineral)",
        optional = "metal_cadmium",
    }

end

function unilib.pkg.mineral_greenockite.exec()

    local c_lump = "unilib:mineral_greenockite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "greenockite",
        description = S("Greenockite"),

        hardness = 2,
        metal_list = {"cadmium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, greenockite.png). Original code
        description = S("Greenockite Lump"),
        inventory_image = "unilib_mineral_greenockite_lump.png",
    })
    if unilib.pkg_executed_table["metal_cadmium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_cadmium_ingot",
            recipe = c_lump,
        })

    end

end
