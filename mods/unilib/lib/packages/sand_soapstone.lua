---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_soapstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_soapstone.init()

    return {
        description = "Soapstone sand",
    }

end

function unilib.pkg.sand_soapstone.exec()

    unilib.register_node("unilib:sand_soapstone", nil, mode, {
        -- Texture from UGBC, andesite_sand.png. Original code
        description = S("Soapstone Sand"),
        tiles = {"unilib_sand_soapstone.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
