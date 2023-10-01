---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_uraninite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_uraninite.init()

    return {
        description = "Uraninite (as mineral)",
        notes = "In real life, uraninite and pitchblende are the same; here, they are two" ..
                " separate packages (but both can be used to produce uranium ingots)",
        optional = "metal_uranium",
    }

end

function unilib.pkg.mineral_uraninite.exec()

    local c_lump = "unilib:mineral_uraninite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "uraninite",
        description = S("Uraninite"),

        hardness = 3,
        metal_list = {"uranium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, uraninite.png). Original code
        description = S("Uraninite Lump"),
        inventory_image = "unilib_mineral_uraninite_lump.png",
    })
    if unilib.pkg_executed_table["metal_uranium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_uranium_ingot",
            recipe = c_lump,
        })

    end

end
