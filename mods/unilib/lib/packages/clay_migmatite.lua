---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_migmatite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_migmatite.init()

    return {
        description = "Migmatite clay",
    }

end

function unilib.pkg.clay_migmatite.exec()

    unilib.register_node("unilib:clay_migmatite", nil, mode, {
        -- Texture from UGBC, migmatite_clay.png. Original code
        description = S("Migmatite Clay"),
        tiles = {"unilib_clay_migmatite.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
