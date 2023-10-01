---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_quartzite_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_quartzite_red.init()

    return {
        description = "Red quartzite sand",
    }

end

function unilib.pkg.sand_quartzite_red.exec()

    unilib.register_node("unilib:sand_quartzite_red", nil, mode, {
        -- Texture from UGBC, quartzite_sand.png. Original code
        description = S("Red Quartzite Sand"),
        tiles = {"unilib_sand_quartzite_red.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
