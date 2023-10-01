---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_almandine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_almandine.init()

    return {
        description = "Almandine (as a mineral)",
    }

end

function unilib.pkg.mineral_almandine.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "almandine",
        description = S("Almandine"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_almandine_lump", nil, mode, {
        -- Texture from AATO, almandine.png. Original code
        description = S("Almandine Lump"),
        inventory_image = "unilib_mineral_almandine_lump.png",
    })

end
