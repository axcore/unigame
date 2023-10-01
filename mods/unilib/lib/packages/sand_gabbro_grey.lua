---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_gabbro_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_gabbro_grey.init()

    return {
        description = "Grey gabbro sand",
    }

end

function unilib.pkg.sand_gabbro_grey.exec()

    unilib.register_node("unilib:sand_gabbro_grey", nil, mode, {
        -- Texture from UGBC, gabbro_sand.png. Original code
        description = S("Grey Gabbro Sand"),
        tiles = {"unilib_sand_gabbro_grey.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
