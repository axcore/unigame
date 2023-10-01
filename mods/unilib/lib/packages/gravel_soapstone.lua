---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_soapstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_soapstone.init()

    return {
        description = "Soapstone gravel",
    }

end

function unilib.pkg.gravel_soapstone.exec()

    unilib.register_node("unilib:gravel_soapstone", nil, mode, {
        -- Texture from UGBC, soapstone_gravel.png. Original code
        description = S("Soapstone Gravel"),
        tiles = {"unilib_gravel_soapstone.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
