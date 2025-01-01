---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_rhyolite_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_rhyolite_dark.init()

    return {
        description = "Dark rhyolite clay",
    }

end

function unilib.pkg.clay_rhyolite_dark.exec()

    unilib.register_node("unilib:clay_rhyolite_dark", nil, mode, {
        -- Texture from UGBC, rhyolite_clay.png. Original code
        description = S("Dark Rhyolite Clay"),
        tiles = {"unilib_clay_rhyolite_dark.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
