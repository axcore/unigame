---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_spessartine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_spessartine.init()

    return {
        description = "Spessartine (as a mineral)",
    }

end

function unilib.pkg.mineral_spessartine.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "spessartine",
        description = S("Spessartine"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_spessartine_lump", nil, mode, {
        -- Texture from AATO, spessartine.png. Original code
        description = S("Spessartine Lump"),
        inventory_image = "unilib_mineral_spessartine_lump.png",
    })

end
