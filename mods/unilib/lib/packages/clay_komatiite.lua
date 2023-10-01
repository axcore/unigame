---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_komatiite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_komatiite.init()

    return {
        description = "Komatiite clay",
    }

end

function unilib.pkg.clay_komatiite.exec()

    unilib.register_node("unilib:clay_komatiite", nil, mode, {
        -- Texture from UGBC, komatiite_clay.png. Original code
        description = S("Komatiite Clay"),
        tiles = {"unilib_clay_komatiite.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,
    })

end
