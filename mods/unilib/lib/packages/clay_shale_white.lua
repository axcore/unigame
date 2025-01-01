---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_shale_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_shale_white.init()

    return {
        description = "White shale clay",
    }

end

function unilib.pkg.clay_shale_white.exec()

    unilib.register_node("unilib:clay_shale_white", nil, mode, {
        -- Texture from UGBC, shale_clay.png. Original code
        description = S("White Shale Clay"),
        tiles = {"unilib_clay_shale_white.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
