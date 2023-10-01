---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_lapis_lazuli = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_lapis_lazuli.init()

    return {
        description = "Lapis lazuli (as mineral)",
    }

end

function unilib.pkg.mineral_lapis_lazuli.exec()

    unilib.register_craftitem("unilib:mineral_lapis_lazuli_lump", nil, mode, {
        -- Original to unilib
        description = S("Lapis Lazuli Lump"),
        inventory_image = "unilib_mineral_lapis_lazuli_lump.png",
    })

end
