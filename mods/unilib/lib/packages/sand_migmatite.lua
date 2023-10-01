---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_migmatite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_migmatite.init()

    return {
        description = "Migmatite sand",
    }

end

function unilib.pkg.sand_migmatite.exec()

    unilib.register_node("unilib:sand_migmatite", nil, mode, {
        -- Texture from UGBC, migmatite_sand.png. Original code
        description = S("Migmatite Sand"),
        tiles = {"unilib_sand_migmatite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
