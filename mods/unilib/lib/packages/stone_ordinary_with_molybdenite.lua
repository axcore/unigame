---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_molybdenite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_molybdenite.init()

    return {
        description = "Ordinary stone with molybdenite as ore",
        depends = {"mineral_molybdenite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_molybdenite.exec()

    unilib.register_node("unilib:stone_ordinary_with_molybdenite", nil, mode, {
        -- Texture from PFAA, weakOreRock_molybdenite.png. Original code
        description = unilib.brackets(S("Molybdenite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_molybdenite.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_molybdenite_lump",
    })

end
