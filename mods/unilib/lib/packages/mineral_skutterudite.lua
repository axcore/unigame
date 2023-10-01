---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_skutterudite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_skutterudite.init()

    return {
        description = "Skutterudite (as mineral)",
        optional = "metal_cobalt",
    }

end

function unilib.pkg.mineral_skutterudite.exec()

    local c_lump = "unilib:mineral_skutterudite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "skutterudite",
        description = S("Skutterudite"),

        hardness = 3,
        metal_list = {"cobalt"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, skutterudite.png). Original code
        description = S("Skutterudite Lump"),
        inventory_image = "unilib_mineral_skutterudite_lump.png",
    })
    if unilib.pkg_executed_table["metal_cobalt"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_cobalt_ingot",
            recipe = c_lump,
        })

    end

end
