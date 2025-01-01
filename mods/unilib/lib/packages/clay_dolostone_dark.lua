---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_dolostone_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_dolostone_dark.init()

    return {
        description = "Dark dolostone clay",
    }

end

function unilib.pkg.clay_dolostone_dark.exec()

    unilib.register_node("unilib:clay_dolostone_dark", nil, mode, {
        -- Texture from UGBC, dolomite_clay.png. Original code
        description = S("Dark Dolostone Clay"),
        tiles = {"unilib_clay_dolostone_dark.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
