---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_gabbro_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_gabbro_grey.init()

    return {
        description = "Grey gabbro gravel",
    }

end

function unilib.pkg.gravel_gabbro_grey.exec()

    unilib.register_node("unilib:gravel_gabbro_grey", nil, mode, {
        -- Texture from UGBC, gabbro_gravel.png. Original code
        description = S("Grey Gabbro Gravel"),
        tiles = {"unilib_gravel_gabbro_grey.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
