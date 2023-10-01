---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_granite_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_granite_orange.init()

    return {
        description = "Orange granite gravel",
    }

end

function unilib.pkg.gravel_granite_orange.exec()

    unilib.register_node("unilib:gravel_granite_orange", nil, mode, {
        -- Texture from UGBC, red_granite_gravel.png. Original code
        description = S("Orange Granite Gravel"),
        tiles = {"unilib_gravel_granite_orange.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
