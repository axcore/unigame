---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_limestone_beige = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_limestone_beige.init()

    return {
        description = "Beige limestone gravel",
    }

end

function unilib.pkg.gravel_limestone_beige.exec()

    unilib.register_node("unilib:gravel_limestone_beige", nil, mode, {
        -- Texture from UGBC, limestone_gravel.png. Original code
        description = S("Beige Limestone Gravel"),
        tiles = {"unilib_gravel_limestone_beige.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
