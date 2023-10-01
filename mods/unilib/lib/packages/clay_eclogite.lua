---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_eclogite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_eclogite.init()

    return {
        description = "Eclogite clay",
    }

end

function unilib.pkg.clay_eclogite.exec()

    unilib.register_node("unilib:clay_eclogite", nil, mode, {
        -- Texture from UGBC, eclogite_clay.png. Original code
        description = S("Eclogite Clay"),
        tiles = {"unilib_clay_eclogite.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,
    })

end
