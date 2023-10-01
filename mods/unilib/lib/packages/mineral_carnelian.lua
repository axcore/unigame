---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_carnelian = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_carnelian.init()

    return {
        description = "Carnelian (as a mineral)",
    }

end

function unilib.pkg.mineral_carnelian.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "carnelian",
        description = S("Carnelian"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_carnelian_lump", nil, mode, {
        -- Texture from AATO, carnelian.png. Original code
        description = S("Carnelian Lump"),
        inventory_image = "unilib_mineral_carnelian_lump.png",
    })

end
