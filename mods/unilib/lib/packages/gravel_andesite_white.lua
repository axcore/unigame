---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_andesite_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_andesite_white.init()

    return {
        description = "White andesite gravel",
    }

end

function unilib.pkg.gravel_andesite_white.exec()

    unilib.register_node("unilib:gravel_andesite_white", nil, mode, {
        -- Texture from UGBC, andesite_gravel.png. Original code
        description = S("White Andesite Gravel"),
        tiles = {"unilib_gravel_andesite_white.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
