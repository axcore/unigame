---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_chert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_chert.init()

    return {
        description = "Chert gravel",
    }

end

function unilib.pkg.gravel_chert.exec()

    unilib.register_node("unilib:gravel_chert", nil, mode, {
        -- Texture from UGBC, chert_gravel.png. Original code
        description = S("Chert Gravel"),
        tiles = {"unilib_gravel_chert.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
