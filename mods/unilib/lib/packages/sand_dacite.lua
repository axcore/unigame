---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_dacite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_dacite.init()

    return {
        description = "Dacite sand",
    }

end

function unilib.pkg.sand_dacite.exec()

    unilib.register_node("unilib:sand_dacite", nil, mode, {
        -- Texture from UGBC, dacite_sand.png. Original code
        description = S("Dacite Sand"),
        tiles = {"unilib_sand_dacite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
