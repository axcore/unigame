---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_komatiite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_komatiite.init()

    return {
        description = "Komatiite sand",
    }

end

function unilib.pkg.sand_komatiite.exec()

    unilib.register_node("unilib:sand_komatiite", nil, mode, {
        -- Texture from UGBC, komatiite_sand.png. Original code
        description = S("Komatiite Sand"),
        tiles = {"unilib_sand_komatiite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
