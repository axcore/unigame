---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_realgar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_realgar.init()

    return {
        description = "Ordinary stone with realgar as ore",
        depends = {"mineral_realgar", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_realgar.exec()

    unilib.register_node("unilib:stone_ordinary_with_realgar", nil, mode, {
        -- Texture from PFAA, weakOreRock_realgar.png. Original code
        description = unilib.brackets(S("Realgar Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_realgar.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_realgar_lump",
    })

end
