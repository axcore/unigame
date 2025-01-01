---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_granite_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_granite_orange.init()

    return {
        description = "Orange granite clay",
    }

end

function unilib.pkg.clay_granite_orange.exec()

    unilib.register_node("unilib:clay_granite_orange", nil, mode, {
        -- Texture from UGBC, red_granite_clay.png. Original code
        description = S("Orange Granite Clay"),
        tiles = {"unilib_clay_granite_orange.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
