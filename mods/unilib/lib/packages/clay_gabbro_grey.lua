---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_gabbro_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_gabbro_grey.init()

    return {
        description = "Grey gabbro clay",
    }

end

function unilib.pkg.clay_gabbro_grey.exec()

    unilib.register_node("unilib:clay_gabbro_grey", nil, mode, {
        -- Texture from UGBC, gabbro_clay.png. Original code
        description = S("Grey Gabbro Clay"),
        tiles = {"unilib_clay_gabbro_grey.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
