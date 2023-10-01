---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_gneiss_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_gneiss_grey.init()

    return {
        description = "Grey gneiss gravel",
    }

end

function unilib.pkg.gravel_gneiss_grey.exec()

    unilib.register_node("unilib:gravel_gneiss_grey", nil, mode, {
        -- Texture from UGBC, gneiss_gravel.png. Original code
        description = S("Grey Gneiss Gravel"),
        tiles = {"unilib_gravel_gneiss_grey.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
