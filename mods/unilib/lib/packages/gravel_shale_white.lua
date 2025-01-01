---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_shale_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_shale_white.init()

    return {
        description = "White shale gravel",
    }

end

function unilib.pkg.gravel_shale_white.exec()

    unilib.register_node("unilib:gravel_shale_white", nil, mode, {
        -- Texture from UGBC, shale_gravel.png. Original code
        description = S("White Shale Gravel"),
        tiles = {"unilib_gravel_shale_white.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

end
