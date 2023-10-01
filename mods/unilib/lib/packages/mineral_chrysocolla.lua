---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_chrysocolla = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_chrysocolla.init()

    return {
        description = "Chrysocolla (as a mineral)",
    }

end

function unilib.pkg.mineral_chrysocolla.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "chrysocolla",
        description = S("Chrysocolla"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_chrysocolla_lump", nil, mode, {
        -- Texture from AATO, chrysocolla.png. Original code
        description = S("Chrysocolla Lump"),
        inventory_image = "unilib_mineral_chrysocolla_lump.png",
    })

end
