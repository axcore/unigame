---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_schist_green_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_schist_green_pale.init()

    return {
        description = "Pale green schist sand",
    }

end

function unilib.pkg.sand_schist_green_pale.exec()

    unilib.register_node("unilib:sand_schist_green_pale", nil, mode, {
        -- Texture from UGBC, greenschist_sand.png. Original code
        description = S("Pale Green Schist Sand"),
        tiles = {"unilib_sand_schist_green_pale.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
