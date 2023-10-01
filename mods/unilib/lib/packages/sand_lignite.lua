---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_lignite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_lignite.init()

    return {
        description = "Lignite sand",
    }

end

function unilib.pkg.sand_lignite.exec()

    unilib.register_node("unilib:sand_lignite", nil, mode, {
        -- Texture from UGBC, lignite_sand.png. Original code
        description = S("Lignite Sand"),
        tiles = {"unilib_sand_lignite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
