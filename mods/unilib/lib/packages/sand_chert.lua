---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_chert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_chert.init()

    return {
        description = "Chert sand",
    }

end

function unilib.pkg.sand_chert.exec()

    unilib.register_node("unilib:sand_chert", nil, mode, {
        -- Texture from UGBC, chert_sand.png. Original code
        description = S("Chert Sand"),
        tiles = {"unilib_sand_chert.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
