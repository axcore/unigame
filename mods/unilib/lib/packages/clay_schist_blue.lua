---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_schist_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_schist_blue.init()

    return {
        description = "Blue schist clay",
    }

end

function unilib.pkg.clay_schist_blue.exec()

    unilib.register_node("unilib:clay_schist_blue", nil, mode, {
        -- Texture from UGBC, blueschist_clay.png. Original code
        description = S("Blue Schist Clay"),
        tiles = {"unilib_clay_schist_blue.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,
    })

end
