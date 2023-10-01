---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_chalk_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_chalk_pink.init()

    return {
        description = "Pink chalk sand",
    }

end

function unilib.pkg.sand_chalk_pink.exec()

    unilib.register_node("unilib:sand_chalk_pink", nil, mode, {
        -- Texture from UGBC, chalk_sand.png. Original code
        description = S("Pink Chalk Sand"),
        tiles = {"unilib_sand_chalk_pink.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
