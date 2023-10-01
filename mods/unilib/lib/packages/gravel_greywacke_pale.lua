---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_greywacke_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_greywacke_pale.init()

    return {
        description = "Pale greywacke gravel",
    }

end

function unilib.pkg.gravel_greywacke_pale.exec()

    unilib.register_node("unilib:gravel_greywacke_pale", nil, mode, {
        -- Texture from UGBC, greywacke_gravel.png. Original code
        description = S("Pale Greywacke Gravel"),
        tiles = {"unilib_gravel_greywacke_pale.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
