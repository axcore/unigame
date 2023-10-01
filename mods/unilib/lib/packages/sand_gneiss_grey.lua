---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_gneiss_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_gneiss_grey.init()

    return {
        description = "Grey gneiss sand",
    }

end

function unilib.pkg.sand_gneiss_grey.exec()

    unilib.register_node("unilib:sand_gneiss_grey", nil, mode, {
        -- Texture from UGBC, gneiss_sand.png. Original code
        description = S("Grey Gneiss Sand"),
        tiles = {"unilib_sand_gneiss_grey.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
