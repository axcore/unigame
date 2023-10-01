---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_limestone_beige = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_limestone_beige.init()

    return {
        description = "Beige limestone sand",
    }

end

function unilib.pkg.sand_limestone_beige.exec()

    unilib.register_node("unilib:sand_limestone_beige", nil, mode, {
        -- Texture from UGBC, limestone_sand.png. Original code
        description = S("Beige Limestone Sand"),
        tiles = {"unilib_sand_limestone_beige.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
