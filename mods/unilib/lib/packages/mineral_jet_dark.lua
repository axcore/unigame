---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_jet_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_jet_dark.init()

    return {
        description = "Dark jet (as a mineral)",
    }

end

function unilib.pkg.mineral_jet_dark.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "jet_dark",
        description = S("Dark Jet"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_jet_dark_lump", nil, mode, {
        -- Texture from AATO, jet.png. Original code
        description = S("Dark Jet Lump"),
        inventory_image = "unilib_mineral_jet_dark_lump.png",
    })

end
