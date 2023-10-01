---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_andesite_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_andesite_white.init()

    return {
        description = "White andesite sand",
    }

end

function unilib.pkg.sand_andesite_white.exec()

    unilib.register_node("unilib:sand_andesite_white", nil, mode, {
        -- Texture from UGBC, andesite_sand.png. Original code
        description = S("White Andesite Sand"),
        tiles = {"unilib_sand_andesite_white.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
