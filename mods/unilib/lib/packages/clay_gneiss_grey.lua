---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_gneiss_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_gneiss_grey.init()

    return {
        description = "Grey gneiss clay",
    }

end

function unilib.pkg.clay_gneiss_grey.exec()

    unilib.register_node("unilib:clay_gneiss_grey", nil, mode, {
        -- Texture from UGBC, gneiss_clay.png. Original code
        description = S("Grey Gneiss Clay"),
        tiles = {"unilib_clay_gneiss_grey.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,
    })

end
