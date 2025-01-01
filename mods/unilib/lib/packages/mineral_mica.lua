---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_mica = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_mica.init()

    return {
        description = "Mica (as mineral)",
    }

end

function unilib.pkg.mineral_mica.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "mica",
        description = S("Mica"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_mica_lump", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Mica Lump"), S("Muscovite")),
        inventory_image = "unilib_mineral_mica_lump.png",
    })

end
