---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_chalk_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_chalk_pink.init()

    return {
        description = "Pink chalk clay",
    }

end

function unilib.pkg.clay_chalk_pink.exec()

    unilib.register_node("unilib:clay_chalk_pink", nil, mode, {
        -- Texture from UGBC, chalk_clay.png. Original code
        description = S("Pink Chalk Clay"),
        tiles = {"unilib_clay_chalk_pink.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,
    })

end
