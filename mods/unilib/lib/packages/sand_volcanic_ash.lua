---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_volcanic_ash = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_volcanic_ash.init()

    return {
        description = "Volcanic ash sand",
    }

end

function unilib.pkg.sand_volcanic_ash.exec()

    unilib.register_node("unilib:sand_volcanic_ash", nil, mode, {
        -- Texture from PFAA, weakOreSand_volcanicAsh.png. Original code
        description = S("Volcanic Ash Sand"),
        tiles = {"unilib_sand_volcanic_ash.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

end
