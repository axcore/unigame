---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_dolostone_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_dolostone_dark.init()

    return {
        description = "Dark dolostone gravel",
    }

end

function unilib.pkg.gravel_dolostone_dark.exec()

    unilib.register_node("unilib:gravel_dolostone_dark", nil, mode, {
        -- Texture from UGBC, dolomite_gravel.png. Original code
        description = S("Dark Dolostone Gravel"),
        tiles = {"unilib_gravel_dolostone_dark.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
