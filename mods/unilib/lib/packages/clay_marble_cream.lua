---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_marble_cream = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_marble_cream.init()

    return {
        description = "Cream marble clay",
    }

end

function unilib.pkg.clay_marble_cream.exec()

    unilib.register_node("unilib:clay_marble_cream", nil, mode, {
        -- Texture from UGBC, marble_clay.png. Original code
        description = S("Cream Marble Clay"),
        tiles = {"unilib_clay_marble_cream.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
