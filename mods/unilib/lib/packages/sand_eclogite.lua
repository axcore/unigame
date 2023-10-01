---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_eclogite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_eclogite.init()

    return {
        description = "Eclogite sand",
    }

end

function unilib.pkg.sand_eclogite.exec()

    unilib.register_node("unilib:sand_eclogite", nil, mode, {
        -- Texture from UGBC, eclogite_sand.png. Original code
        description = S("Eclogite Sand"),
        tiles = {"unilib_sand_eclogite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
