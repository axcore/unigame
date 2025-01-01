---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_chert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_chert.init()

    return {
        description = "Chert clay",
    }

end

function unilib.pkg.clay_chert.exec()

    unilib.register_node("unilib:clay_chert", nil, mode, {
        -- Texture from UGBC, chert_clay.png. Original code
        description = S("Chert Clay"),
        tiles = {"unilib_clay_chert.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
