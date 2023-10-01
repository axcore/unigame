---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_monazite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_monazite.init()

    return {
        description = "Monazite (as mineral)",
        optional = "metal_cerium",
    }

end

function unilib.pkg.mineral_monazite.exec()

    local c_lump = "unilib:mineral_monazite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "monazite",
        description = S("Monazite"),

        hardness = 3,
        metal_list = {"cerium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, monazite.png). Original code
        description = S("Monazite Lump"),
        inventory_image = "unilib_mineral_monazite_lump.png",
    })
    if unilib.pkg_executed_table["metal_cerium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_cerium_chunk",
            recipe = c_lump,
        })

    end

end
