---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_quartzite_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_quartzite_red.init()

    return {
        description = "Red quartzite clay",
    }

end

function unilib.pkg.clay_quartzite_red.exec()

    unilib.register_node("unilib:clay_quartzite_red", nil, mode, {
        -- Texture from UGBC, quartzite_clay.png. Original code
        description = S("Red Quartzite Clay"),
        tiles = {"unilib_clay_quartzite_red.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
