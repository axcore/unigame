---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_peridot = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_peridot.init()

    return {
        description = "Peridot (as a mineral)",
    }

end

function unilib.pkg.mineral_peridot.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "peridot",
        description = S("Peridot"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_peridot_lump", nil, mode, {
        -- Texture from AATO, peridot.png. Original code
        description = unilib.brackets(S("Peridot Lump"), S("Chrysolite")),
        inventory_image = "unilib_mineral_peridot_lump.png",
    })

end
