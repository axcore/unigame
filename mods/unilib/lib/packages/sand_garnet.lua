---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_garnet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_garnet.init()

    return {
        description = "Garnet sand",
    }

end

function unilib.pkg.sand_garnet.exec()

    unilib.register_node("unilib:sand_garnet", nil, mode, {
        -- Texture from PFAA, weakOreSand_garnetSand.png. Original code
        description = S("Garnet Sand"),
        tiles = {"unilib_sand_garnet.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
