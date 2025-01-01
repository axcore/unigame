---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_chrysotile = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_chrysotile.init()

    return {
        description = "Ordinary stone with chrysotile as ore",
        depends = {"mineral_chrysotile", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_chrysotile.exec()

    unilib.register_node("unilib:stone_ordinary_with_chrysotile", nil, mode, {
        -- Texture from PFAA, weakOreRock_chrysotile.png. Original code
        description = unilib.utils.brackets(S("Chrysotile Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_chrysotile.png"},
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_chrysotile_lump",
    })

end
