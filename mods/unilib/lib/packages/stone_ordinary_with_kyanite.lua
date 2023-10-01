---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_kyanite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_kyanite.init()

    return {
        description = "Ordinary stone with kyanite as ore",
        depends = {"mineral_kyanite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_kyanite.exec()

    unilib.register_node("unilib:stone_ordinary_with_kyanite", nil, mode, {
        -- Texture from PFAA, strongOreRock_kyanite.png. Original code
        description = unilib.brackets(S("Kyanite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_kyanite.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_kyanite_lump",
    })

end
