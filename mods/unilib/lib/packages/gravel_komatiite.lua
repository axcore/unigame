---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_komatiite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_komatiite.init()

    return {
        description = "Komatiite gravel",
    }

end

function unilib.pkg.gravel_komatiite.exec()

    unilib.register_node("unilib:gravel_komatiite", nil, mode, {
        -- Texture from UGBC, komatiite_gravel.png. Original code
        description = S("Komatiite Gravel"),
        tiles = {"unilib_gravel_komatiite.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
