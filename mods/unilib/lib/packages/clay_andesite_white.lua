---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_andesite_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_andesite_white.init()

    return {
        description = "White andesite clay",
    }

end

function unilib.pkg.clay_andesite_white.exec()

    unilib.register_node("unilib:clay_andesite_white", nil, mode, {
        -- Texture from UGBC, andesite_clay.png. Original code
        description = S("White Andesite Clay"),
        tiles = {"unilib_clay_andesite_white.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
