---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_schist_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_schist_blue.init()

    return {
        description = "Blue schist sand",
    }

end

function unilib.pkg.sand_schist_blue.exec()

    unilib.register_node("unilib:sand_schist_blue", nil, mode, {
        -- Texture from UGBC, blueschist_sand.png. Original code
        description = S("Blue Schist Sand"),
        tiles = {"unilib_sand_schist_blue.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
