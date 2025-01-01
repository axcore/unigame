---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_limestone_beige = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_limestone_beige.init()

    return {
        description = "Beige limestone clay",
    }

end

function unilib.pkg.clay_limestone_beige.exec()

    unilib.register_node("unilib:clay_limestone_beige", nil, mode, {
        -- Texture from UGBC, limestone_clay.png. Original code
        description = S("Beige Limestone Clay"),
        tiles = {"unilib_clay_limestone_beige.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
