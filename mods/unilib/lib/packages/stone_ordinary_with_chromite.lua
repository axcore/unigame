---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_chromite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_chromite.init()

    return {
        description = "Ordinary stone with chromite as ore",
        depends = {"mineral_chromite", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_chromite.exec()

    unilib.register_node("unilib:stone_ordinary_with_chromite", nil, mode, {
        -- Texture from PFAA, strongOreRock_chromite.png. Original code
        description = unilib.brackets(S("Chromite Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_chromite.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_chromite_lump",
    })

end
