---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_soapstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_soapstone.init()

    return {
        description = "Soapstone clay",
    }

end

function unilib.pkg.clay_soapstone.exec()

    unilib.register_node("unilib:clay_soapstone", nil, mode, {
        -- Texture from UGBC, soapstone_clay.png. Original code
        description = S("Soapstone Clay"),
        tiles = {"unilib_clay_soapstone.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,
    })

end
