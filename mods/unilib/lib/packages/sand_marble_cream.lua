---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_marble_cream = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_marble_cream.init()

    return {
        description = "Cream marble sand",
    }

end

function unilib.pkg.sand_marble_cream.exec()

    unilib.register_node("unilib:sand_marble_cream", nil, mode, {
        -- Texture from UGBC, marble_sand.png. Original code
        description = S("Cream Marble Sand"),
        tiles = {"unilib_sand_marble_cream.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
