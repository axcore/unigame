---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_wollastonite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_wollastonite.init()

    return {
        description = "Wollastonite (as mineral)",
        optional = "metal_calcium",
    }

end

function unilib.pkg.mineral_wollastonite.exec()

    local c_lump = "unilib:mineral_wollastonite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "wollastonite",
        description = S("Wollastonite"),

        hardness = 2,
        metal_list = {"calcium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = S("Wollastonite Lump"),
        inventory_image = "unilib_mineral_wollastonite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_calcium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_calcium_chunk",
            recipe = c_lump,
        })

    end

end
