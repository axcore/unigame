---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_quartzite_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_quartzite_red.init()

    return {
        description = "Red quartzite gravel",
    }

end

function unilib.pkg.gravel_quartzite_red.exec()

    unilib.register_node("unilib:gravel_quartzite_red", nil, mode, {
        -- Texture from UGBC, quartzite_gravel.png. Original code
        description = S("Red Quartzite Gravel"),
        tiles = {"unilib_gravel_quartzite_red.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
