---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_dacite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_dacite.init()

    return {
        description = "Dacite clay",
    }

end

function unilib.pkg.clay_dacite.exec()

    unilib.register_node("unilib:clay_dacite", nil, mode, {
        -- Texture from UGBC, dacite_clay.png. Original code
        description = S("Dacite Clay"),
        tiles = {"unilib_clay_dacite.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
