---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_granite_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_granite_orange.init()

    return {
        description = "Orange granite sand",
    }

end

function unilib.pkg.sand_granite_orange.exec()

    unilib.register_node("unilib:sand_granite_orange", nil, mode, {
        -- Texture from UGBC, red_granite_sand.png. Original code
        description = S("Orange Granite Sand"),
        tiles = {"unilib_sand_granite_orange.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
