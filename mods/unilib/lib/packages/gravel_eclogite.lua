---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_eclogite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_eclogite.init()

    return {
        description = "Eclogite gravel",
    }

end

function unilib.pkg.gravel_eclogite.exec()

    unilib.register_node("unilib:gravel_eclogite", nil, mode, {
        -- Texture from UGBC, eclogite_gravel.png. Original code
        description = S("Eclogite Gravel"),
        tiles = {"unilib_gravel_eclogite.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
