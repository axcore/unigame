---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_iron_telluric = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_iron_telluric.init()

    return {
        description = "Telluric iron (as mineral)",
        optional = "metal_iron_pig",
    }

end

function unilib.pkg.mineral_iron_telluric.exec()

    local c_lump = "unilib:mineral_iron_telluric_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "iron_telluric",
        description = S("Telluric Iron"),

        hardness = 2,
        metal_list = {"iron_pig"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, telluric_iron.png). Original code
        description = S("Telluric Iron Lump"),
        inventory_image = "unilib_mineral_iron_telluric_lump.png",
    })
    if unilib.pkg_executed_table["metal_iron_pig"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_iron_pig_ingot",
            recipe = c_lump,
        })

    end

end
