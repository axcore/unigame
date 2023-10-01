---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ordinary_with_oil_crude = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ordinary_with_oil_crude.init()

    return {
        description = "Ordinary sand with crude oil",
    }

end

function unilib.pkg.sand_ordinary_with_oil_crude.exec()

    unilib.register_node("unilib:sand_ordinary_with_oil_crude", nil, mode, {
        -- Texture from PFAA, weakOreSand_quartzSand.png. Original code
        description = S("Ordinary Sand with Crude Oil"),
        tiles = {"unilib_sand_ordinary_with_oil_crude.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
