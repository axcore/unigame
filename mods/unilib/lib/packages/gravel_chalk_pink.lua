---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_chalk_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_chalk_pink.init()

    return {
        description = "Pink chalk gravel",
    }

end

function unilib.pkg.gravel_chalk_pink.exec()

    unilib.register_node("unilib:gravel_chalk_pink", nil, mode, {
        -- Texture from UGBC, chalk_gravel.png. Original code
        description = S("Pink Chalk Gravel"),
        tiles = {"unilib_gravel_chalk_pink.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
