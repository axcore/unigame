---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_migmatite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_migmatite.init()

    return {
        description = "Migmatite gravel",
    }

end

function unilib.pkg.gravel_migmatite.exec()

    unilib.register_node("unilib:gravel_migmatite", nil, mode, {
        -- Texture from UGBC, migmatite_gravel.png. Original code
        description = S("Migmatite Gravel"),
        tiles = {"unilib_gravel_migmatite.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
