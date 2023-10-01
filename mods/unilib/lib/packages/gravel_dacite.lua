---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_dacite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_dacite.init()

    return {
        description = "Dacite gravel",
    }

end

function unilib.pkg.gravel_dacite.exec()

    unilib.register_node("unilib:gravel_dacite", nil, mode, {
        -- Texture from UGBC, dacite_gravel.png. Original code
        description = S("Dacite Gravel"),
        tiles = {"unilib_gravel_dacite.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
